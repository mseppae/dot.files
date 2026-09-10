-- Odin: run the project. `odin run` builds and runs in one step, so there's
-- no separate build mapping — the build alone would never be useful here.
vim.keymap.set("n", "<leader>or", function()
	local root = vim.fs.root(0, { "ols.json", ".git" }) or vim.fn.getcwd()
	vim.cmd("botright 15split | terminal cd " .. vim.fn.fnameescape(root) .. " && odin run .")
	vim.cmd("startinsert")
end, { buffer = true, desc = "Odin: run project" })
