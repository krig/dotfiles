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

-- Use the defaults as a base
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- match work bug numbers
table.insert(config.hyperlink_rules, {
  regex = [[\bGAS-(\d+)\b]],
  format = 'https://netinsight.atlassian.net/browse/GAS-$1',
})

-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
table.insert(config.hyperlink_rules, {
  regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
  format = 'https://www.github.com/$1/$3',
})

return config
