-- Project trust: language servers and formatters can run a project's own code
-- (zls runs build.zig, ruby-lsp evaluates the Gemfile, prettierd and rubocop
-- load project config/plugins), so they only start in trusted directories.
-- Trusting a directory trusts everything below it. The list is machine-local:
-- stdpath("state")/trusted-projects, one absolute path per line.
local M = {}

local trust_file = vim.fn.stdpath("state") .. "/trusted-projects"
local notified = {}

local function normalize(path)
	path = vim.fs.normalize(vim.fn.fnamemodify(path, ":p"))
	path = vim.uv.fs_realpath(path) or path
	return (path:gsub("/$", ""))
end

local function read()
	local ok, lines = pcall(vim.fn.readfile, trust_file)
	if not ok then
		return {}
	end
	return vim.tbl_filter(function(line)
		return line ~= ""
	end, lines)
end

local function write(entries)
	vim.fn.mkdir(vim.fs.dirname(trust_file), "p")
	vim.fn.writefile(entries, trust_file)
end

local function is_under(path, dir)
	return path == dir or path:sub(1, #dir + 1) == dir .. "/"
end

function M.is_trusted(path)
	if not path or path == "" then
		return false
	end
	path = normalize(path)
	for _, dir in ipairs(read()) do
		if is_under(path, dir) then
			return true
		end
	end
	return false
end

-- The directory a buffer belongs to: its git root, else the file's directory.
function M.project_root(bufnr)
	bufnr = bufnr or 0
	local name = vim.api.nvim_buf_get_name(bufnr)
	if name == "" then
		return vim.fn.getcwd()
	end
	return vim.fs.root(bufnr, ".git") or vim.fs.dirname(name)
end

function M.buf_trusted(bufnr)
	return M.is_trusted(M.project_root(bufnr))
end

-- Tell the user once per directory why tools are not running there.
function M.notify_untrusted(root)
	root = normalize(root)
	if notified[root] then
		return
	end
	notified[root] = true
	vim.schedule(function()
		vim.notify(
			"Untrusted project, LSP and formatters are off: " .. root .. "\nRun :Trust to enable them.",
			vim.log.levels.WARN
		)
	end)
end

-- Wrap an LSP config's root detection so the server only starts in trusted
-- directories. A root_dir function takes precedence over root_markers.
function M.gate_lsp(name)
	local config = vim.lsp.config[name]
	if not config then
		return
	end
	local root_dir, root_markers = config.root_dir, config.root_markers
	vim.lsp.config(name, {
		root_dir = function(bufnr, on_dir)
			local function start_if_trusted(root)
				local check = root or vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
				if M.is_trusted(check) then
					on_dir(root)
				else
					M.notify_untrusted(check)
				end
			end
			if type(root_dir) == "function" then
				root_dir(bufnr, start_if_trusted)
			elseif type(root_dir) == "string" then
				start_if_trusted(root_dir)
			else
				start_if_trusted(root_markers and vim.fs.root(bufnr, root_markers) or nil)
			end
		end,
	})
end

local function target(args)
	return normalize(args.args ~= "" and args.args or M.project_root(0))
end

vim.api.nvim_create_user_command("Trust", function(args)
	local dir = target(args)
	local entries = read()
	if not vim.tbl_contains(entries, dir) then
		table.insert(entries, dir)
		write(entries)
	end
	notified[dir] = nil
	vim.notify("Trusted " .. dir)
	-- Re-run LSP activation for open buffers, as vim.lsp.enable() does.
	vim.cmd.doautoall("nvim.lsp.enable FileType")
end, { nargs = "?", complete = "dir", desc = "Trust a project (default: current git root)" })

vim.api.nvim_create_user_command("Untrust", function(args)
	local dir = target(args)
	write(vim.tbl_filter(function(entry)
		return not is_under(entry, dir)
	end, read()))
	for _, client in ipairs(vim.lsp.get_clients()) do
		-- Single-file clients have no root; judge them by a buffer's directory,
		-- as gate_lsp does.
		local check = client.root_dir
		if not check then
			local bufnr = next(client.attached_buffers)
			check = bufnr and vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
		end
		if check and not M.is_trusted(check) then
			client:stop()
		end
	end
	if M.is_trusted(dir) then
		vim.notify(dir .. " is still trusted through a parent directory; see :TrustList", vim.log.levels.WARN)
	else
		vim.notify("Untrusted " .. dir)
	end
end, { nargs = "?", complete = "dir", desc = "Stop trusting a project (default: current git root)" })

vim.api.nvim_create_user_command("TrustList", function()
	local entries = read()
	vim.notify(#entries > 0 and table.concat(entries, "\n") or "No trusted projects")
end, { desc = "List trusted projects" })

return M
