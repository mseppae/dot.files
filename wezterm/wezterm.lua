-- Default keys: https://wezfurlong.org/wezterm/config/default-keys.html

local wezterm = require 'wezterm'
local config = {}

-- TODO: parallax fancynes:
-- * https://wezfurlong.org/wezterm/config/lua/config/background.html
-- * https://www.gameartguppy.com/product-category/game-art-background-sprites/
-- 
-- current wallpaper from https://github.com/ItsTerm3n4l/Wallpapers
config.window_background_image = wezterm.home_dir .. "/.config/Wallpapers/Night.png"
config.window_background_image_hsb = {
  brightness = 0.02,
  hue = 1.0,
  saturation = 0.2,
}

return config
