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
    dashboard.button( "r", "> Recent files"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "f", "> Find in ~/src", ":cd $HOME/src | Telescope find_files<CR>"),
    dashboard.button( "c", "> Find in ~/.config/nvim" , ":cd $HOME/.config/nvim | Telescope find_files<CR>"),
    dashboard.button( "q", "> Quit NVIM", ":qa<CR>"),
}

dashboard.section.footer.hl = "NvimTreeRootFolder"
dashboard.section.footer.val = {
    '◔ ' .. os.date('%Y %m %d %H:%M') .. ' ☀ ' .. vim.fn.getcwd(),
}

-- Send config to alpha
alpha.setup(dashboard.opts)

