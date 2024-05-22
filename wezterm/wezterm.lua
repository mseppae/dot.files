-- Default keys: https://wezfurlong.org/wezterm/config/default-keys.html

local wezterm = require("wezterm")
local config = {}

-- TODO: parallax fancynes:
-- * https://wezfurlong.org/wezterm/config/lua/config/background.html
-- * https://www.gameartguppy.com/product-category/game-art-background-sprites/
--

-- NOTE: Wallpaper not committed, currently using https://wallhaven.cc/w/85x6jo
config.window_background_image = wezterm.home_dir .. "/.config/Wallpapers/Wallpaper.jpg"
config.window_background_image_hsb = {
	brightness = 0.02,
	hue = 0.8,
	saturation = 0.7,
}

return config
