local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font("Iosevka Term SS07")
config.font_size = 14
-- config.color_scheme = "Catppuccin Mocha"
config.color_scheme = "Catppuccin Frappé (Gogh)"

config.keys = {
	{
		key = "i",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "u",
		mods = "CMD",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "LeftArrow",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
}

return config
