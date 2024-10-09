local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

--config.font = wezterm.font("Iosevka Term SS07")
config.font = wezterm.font("Cascadia Mono PL")
config.font_size = 16
-- config.color_scheme = "Catppuccin Mocha"
config.color_scheme = "Catppuccin Frappé (Gogh)"
-- config.color_scheme = "Kanagawa (Gogh)"
config.bold_brightens_ansi_colors = true

config.keys = {
	{
		key = "C",
		mods = "CMD",
		action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
	},
	{ key = 'V', mods = 'CMD', action = wezterm.action.PasteFrom 'Clipboard' },
	{ key = 'P', mods = 'CMD', action = wezterm.action.PasteFrom 'PrimarySelection' },
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
		key = "d",
		mods = "CMD|SHIFT",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
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
