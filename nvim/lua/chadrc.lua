---@type ChadrcConfig
-- Overwrites the base config https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua
local M = {}

M.ui = {
	theme = "doomchad",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
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
