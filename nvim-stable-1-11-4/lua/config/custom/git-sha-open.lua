local M = {}

-- Function to get the git SHA for the current line
function M.get_git_sha_and_open()
	-- Get the current file and line number
	local file = vim.fn.expand("%:p")
	local line = vim.fn.line(".")

	-- Run git blame to get the SHA for the current line
	local cmd = string.format("git blame -L %d,%d --porcelain %s | grep '^\\w\\{40\\}' | head -1", line, line, file)
	local handle = io.popen(cmd)
	if not handle then
		vim.notify("Failed to execute git blame", vim.log.levels.ERROR)
		return
	end

	local sha = handle:read("*a"):match("^(%w+)")
	handle:close()

	if not sha then
		vim.notify("Could not find git SHA for the current line", vim.log.levels.ERROR)
		return
	end

	-- Get the remote URL
	local remote_cmd = "git config --get remote.origin.url"
	local remote_handle = io.popen(remote_cmd)
	if not remote_handle then
		vim.notify("Failed to get git remote URL", vim.log.levels.ERROR)
		return
	end

	local remote_url = remote_handle:read("*a"):gsub("\n", "")
	remote_handle:close()
	-- extract project domain from remote URL
	local project_domain = remote_url:match("git@(.-)%:.-.git") or remote_url:match("https://(.-)%/.-.git")
	if not project_domain then
		vim.notify("Could not parse project domain from remote URL", vim.log.levels.ERROR)
		return
	end

	-- Extract project path from remote URL
	local project_path = remote_url:match("https://[^/]+/(.-)%.git") or remote_url:match("ssh://[^/]+:?%d*/(.-)%.git")
	if not project_path then
		vim.notify("Could not parse project path from remote URL", vim.log.levels.ERROR)
		return
	end

	-- Construct the domain commit URL
	local commit_url
	if project_domain:match("gitlab") then
		commit_url = string.format("https://%s/%s/-/commit/%s", project_domain, project_path, sha)
	else
		commit_url = string.format("https://%s/%s/commit/%s", project_domain, project_path, sha)
	end

	-- Open the URL in the default web browser
	local open_cmd
	if vim.fn.has("mac") == 1 then
		open_cmd = string.format("open %q", commit_url)
	elseif vim.fn.has("unix") == 1 then
		open_cmd = string.format("xdg-open %q", commit_url)
	else
		vim.notify("Unsupported OS for opening browser", vim.log.levels.ERROR)
		return
	end

	local success = os.execute(open_cmd)
	if success then
		vim.notify("Opened commit in browser: " .. sha, vim.log.levels.INFO)
	else
		vim.notify("Failed to open browser", vim.log.levels.ERROR)
	end
end

-- Create a Neovim command to call the function
vim.api.nvim_create_user_command("GitOpenBlameHash", M.get_git_sha_and_open, {})

return M
