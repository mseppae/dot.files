-- keystats: count mapping hits, ex command names and lazy.nvim plugin loads,
-- to find out which keys and plugins are actually used. Never sees typed text:
-- no vim.on_key, only wraps mappings defined with vim.keymap.set, so it must be
-- loaded before anything sets mappings. :KeyStats [N] shows the totals, kept in
-- stdpath("state")/keystats.json.
local M = {}
local uv = vim.uv
M.path = vim.fn.stdpath("state") .. "/keystats.json"
-- known: desc of every mapping seen; global: those not local to a buffer
-- (picker keys, LSP keys), the only ones listed as never used.
local keys, ids, known, global = {}, {}, {}, {}
local pending = { mappings = {}, commands = {}, plugins = {} }

local function bump(section, name, desc)
	local e = pending[section][name] or { count = 0 }
	e.count, e.last, e.desc = e.count + 1, os.time(), desc or e.desc
	pending[section][name] = e
end

function M.hit(id)
	local k = keys[id]
	bump("mappings", k, known[k])
end

local function register(mode, lhs, desc, buffer)
	local k = (mode == "" and "nvo" or mode) .. " " .. lhs
	if not ids[k] then
		keys[#keys + 1], ids[k] = k, #keys + 1
	end
	known[k] = desc or known[k] or false
	if not buffer then
		global[k] = true
	end
	return ids[k]
end

local set = vim.keymap.set
vim.keymap.set = function(modes, lhs, rhs, opts)
	if lhs:find("^<Plug>") or rhs == "" or (type(rhs) == "string" and rhs:lower() == "<nop>") then
		return set(modes, lhs, rhs, opts)
	end
	for _, mode in ipairs(type(modes) == "table" and modes or { modes }) do
		local id = register(mode, lhs, opts and opts.desc, opts and opts.buffer)
		local r = rhs
		if type(rhs) == "function" then
			r = function(...)
				M.hit(id)
				return rhs(...)
			end
		elseif opts and opts.expr then
			r = function()
				M.hit(id)
				return vim.api.nvim_eval(rhs)
			end
		else
			r = "<Cmd>lua require('config.keystats').hit(" .. id .. ")<CR>" .. rhs
		end
		set(mode, lhs, r, opts)
	end
end

local function read()
	local f = io.open(M.path, "r")
	if not f then
		return { mappings = {}, commands = {}, plugins = {} }
	end
	local ok, data = pcall(vim.json.decode, f:read("*a"))
	f:close()
	return ok and type(data) == "table" and data or { mappings = {}, commands = {}, plugins = {} }
end

-- Merge this session's deltas into the file, then write atomically (tmp + rename).
function M.flush()
	vim.fn.mkdir(vim.fs.dirname(M.path), "p")
	local lock = M.path .. ".lock" -- mkdir is atomic: serialises concurrent instances
	for i = 1, 200 do
		if uv.fs_mkdir(lock, 448) then
			break
		end
		if i == 200 then -- stale lock after ~2s: take it over
			uv.fs_rmdir(lock)
			uv.fs_mkdir(lock, 448)
		else
			uv.sleep(10)
		end
	end
	local ok, data = pcall(M._merge)
	uv.fs_rmdir(lock)
	return assert(ok and data, data)
end

function M._merge()
	local data = read()
	for section, entries in pairs(pending) do
		data[section] = data[section] or {}
		for name, e in pairs(entries) do
			local d = data[section][name] or { count = 0 }
			d.count, d.last, d.desc = d.count + e.count, math.max(d.last or 0, e.last), e.desc or d.desc
			data[section][name] = d
		end
	end
	local tmp = M.path .. ".tmp." .. uv.os_getpid()
	local f = assert(io.open(tmp, "w"))
	f:write(vim.json.encode(data))
	f:close()
	assert(uv.fs_rename(tmp, M.path))
	pending = { mappings = {}, commands = {}, plugins = {} } -- only cleared once written
	return data
end

function M.report(n)
	local data, rows, unused = M.flush(), {}, {}
	for k, e in pairs(data.mappings) do
		rows[#rows + 1] = { k, e.count, e.desc }
	end
	table.sort(rows, function(a, b)
		return a[2] > b[2]
	end)
	local out = { "Top mappings:" }
	for i = 1, math.min(n or 20, #rows) do
		out[#out + 1] = ("%6d  %-24s %s"):format(rows[i][2], rows[i][1], rows[i][3] or "")
	end
	for k in pairs(global) do
		if not data.mappings[k] then
			unused[#unused + 1] = ("        %-24s %s"):format(k, known[k] or "")
		end
	end
	table.sort(unused)
	out[#out + 1] = "Never used (defined this session):"
	vim.list_extend(out, unused)
	for _, s in ipairs({ "commands", "plugins" }) do
		out[#out + 1] = s .. ": " .. vim.inspect(vim.tbl_map(function(e)
			return e.count
		end, data[s]))
	end
	return table.concat(out, "\n")
end

function M.setup(opts)
	opts = opts or {}
	M.path = opts.path or M.path
	local g = vim.api.nvim_create_augroup("keystats", { clear = true })
	vim.api.nvim_create_autocmd("CmdlineLeave", {
		group = g,
		callback = function()
			if vim.fn.getcmdtype() ~= ":" or vim.v.event.abort then
				return
			end
			local ok, cmd = pcall(vim.api.nvim_parse_cmd, vim.fn.getcmdline(), {})
			if ok and cmd.cmd then
				bump("commands", cmd.cmd)
			end
		end,
	})
	vim.api.nvim_create_autocmd("User", {
		group = g,
		pattern = "LazyLoad",
		callback = function(ev)
			bump("plugins", ev.data)
		end,
	})
	vim.api.nvim_create_autocmd("VimLeavePre", {
		group = g,
		callback = function()
			pcall(M.flush)
		end,
	})
	local t = uv.new_timer()
	t:start(
		300000,
		300000,
		vim.schedule_wrap(function()
			pcall(M.flush)
		end)
	)
	t:unref()
	vim.api.nvim_create_user_command("KeyStats", function(a)
		print(M.report(tonumber(a.args)))
	end, { nargs = "?" })
end

return M
