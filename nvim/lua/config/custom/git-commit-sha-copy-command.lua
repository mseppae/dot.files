local function copy_blame_commit_hash()
	-- Get the current buffer and line number
	local bufnr = vim.api.nvim_get_current_buf()
	local line = vim.api.nvim_win_get_cursor(0)[1] -- 1-based line number
	local file = vim.api.nvim_buf_get_name(bufnr)

	-- Run git blame for the current line
	local cmd = string.format("git blame -L %d,%d --porcelain %s", line, line, vim.fn.shellescape(file))
	local output = vim.fn.system(cmd)

	if vim.v.shell_error ~= 0 then
		vim.notify("Error running git blame: " .. output, vim.log.levels.ERROR)
		return
	end

	-- Extract the commit hash from the output
	local commit_hash = output:match("^(%w+)")
	if commit_hash and commit_hash ~= "0000000000000000000000000000000000000000" then
		-- Copy to system clipboard
		vim.fn.setreg("+", commit_hash)
		vim.notify("Copied commit hash: " .. commit_hash, vim.log.levels.INFO)
	else
		vim.notify("No commit hash found for this line", vim.log.levels.WARN)
	end
end

vim.api.nvim_create_user_command("GitsignsCopyBlameHash", copy_blame_commit_hash, {})
