local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

lualine.setup({
  sections = {
    lualine_a = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    },
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_x = {'filetype'},
    lualine_c = {},
  }
})
