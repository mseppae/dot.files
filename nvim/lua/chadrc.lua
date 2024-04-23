---@type ChadrcConfig
-- Overwrites the base config https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua
local M = {}

M.ui = {
  theme = "doomchad",

  tabufline = {
    enabled = false,
  },

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
