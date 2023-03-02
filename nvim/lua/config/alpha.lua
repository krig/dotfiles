local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
	" _._     _,-'\"\"`-._    ",
	"(,-.`._,'(       |\\`-/|",
	"    `-.-' \\ )-`( , o o)",
	"          `-    \\`_`\"'-",
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "r", "↺ Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "p", "♞ Browse ~/src", ":cd $HOME/src | Telescope file_browser<CR>"),
    dashboard.button( "c", "◉ Find in ~/.config/nvim" , ":cd $HOME/.config/nvim | Telescope find_files<CR>"),
    dashboard.button( "q", "⏻ Quit NVIM", ":qa<CR>"),
}

dashboard.section.footer.val = '◔ ' .. os.date('%Y %m %d %H:%M') .. ' ☀ ' .. vim.fn.getcwd()
dashboard.section.footer.hl = "NvimTreeRootFolder"

-- Send config to alpha
alpha.setup(dashboard.opts)

