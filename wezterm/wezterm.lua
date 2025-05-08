-- Default keys: https://wezfurlong.org/wezterm/config/default-keys.html

local w = require("wezterm")
local config = w.config_builder()
local act = w.action

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

w.on("update-right-status", function(window, pane)
	window:set_right_status(window:active_workspace(), pane:active_pane_index())
end)

config.keys = {}

local function is_vim(pane)
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = w.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

config.keys = {
	{
		mods = "LEADER",
		key = "-",
		action = w.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "=",
		action = w.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "m",
		action = w.action.TogglePaneZoomState,
	},
	{
		mods = "LEADER",
		key = "Space",
		action = w.action.RotatePanes("Clockwise"),
	},
	{
		mods = "LEADER",
		key = "0",
		action = w.action.PaneSelect({
			mode = "SwapWithActive",
		}),
	},
	{
		mods = "LEADER",
		key = "Enter",
		action = w.action.ActivateCopyMode,
	},
	{
		mods = "LEADER",
		key = "w",
		action = act.ShowLauncherArgs({ flags = "WORKSPACES" }),
	},
	{
		mods = "LEADER",
		key = "n",
		action = act.SwitchWorkspaceRelative(1),
	},
	{
		mods = "LEADER",
		key = "p",
		action = act.SwitchWorkspaceRelative(-1),
	},
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),
	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),
}

-- NOTE: Wallpaper not committed, currently using https://wallhaven.cc/w/85x6jo
config.window_background_image = w.home_dir .. "/.config/Wallpapers/wezterm.jpg"
config.window_background_image_hsb = {
	brightness = 0.02,
	hue = 0.8,
	saturation = 0.7,
}

return config
