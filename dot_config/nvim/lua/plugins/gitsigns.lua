-- The commit the current branch started from, found the way herdr-reviewr
-- finds its base: the base picked in reviewr, else origin/HEAD,
-- init.defaultBranch, main, master. Nil on that branch itself, so it keeps
-- the default (uncommitted) signs.
local function branch_start(file)
	local dir = vim.fs.dirname(file)
	local function git(...)
		local out = vim.system({ "git", "-C", dir, ... }, { text = true }):wait()
		return out.code == 0 and vim.trim(out.stdout) or nil
	end
	local targets = {
		git("cat-file", "blob", "refs/worktree/reviewr/base-pick"),
		git("rev-parse", "--verify", "--quiet", "origin/HEAD") and "origin/HEAD",
		git("config", "init.defaultBranch"),
		"main",
		"master",
	}
	for i = 1, 5 do
		local base = targets[i] and git("merge-base", "HEAD", targets[i])
		if base then
			return base ~= git("rev-parse", "HEAD") and base or nil
		end
	end
end

return {
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			current_line_blame = true, -- Enable blame on current line
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- End of line
				delay = 250,
				ignore_whitespace = false,
			},
			-- Signs show everything the branch changed, committed or not, to
			-- match what herdr-reviewr's branch view shows for the file.
			on_attach = function(bufnr)
				local base = branch_start(vim.api.nvim_buf_get_name(bufnr))
				if not base then
					return
				end
				-- Switched after the first update: an earlier switch is overwritten
				-- by the rest of the attach.
				vim.api.nvim_create_autocmd("User", {
					pattern = "GitSignsUpdate",
					callback = function(args)
						if not (args.data and args.data.buffer == bufnr) then
							return
						end
						if vim.api.nvim_buf_is_valid(bufnr) then
							vim.api.nvim_buf_call(bufnr, function()
								require("gitsigns").change_base(base)
							end)
						end
						return true
					end,
				})
			end,
		},
	},
}
