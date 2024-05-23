---@type ChadrcConfig
-- Overwrites the base config https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua
local M = {}

local statusline_order =
  { "mode", "git", "relativepath", "file", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" }

local stbufnr = function()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

M.ui = {
  theme = "ayu_dark",

  tabufline = {
    enabled = false,
  },

  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "default",
    order = statusline_order,
    modules = {
      relativepath = function()
        local path = vim.api.nvim_buf_get_name(stbufnr())

        if path == "" then
          return ""
        end

        return "%#St_relativepath#  " .. vim.fn.expand "%:.:h" .. "/"
      end,
    },
  },

  telescope = { style = "bordered" },

  term = {
    float = {
      row = 0.01,
      col = 0.04,
      width = 0.9,
      height = 0.9,
    },
  },
}

return M
