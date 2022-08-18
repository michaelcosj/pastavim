-- Kanagawa
require("kanagawa").setup({
	undercurl = true, -- enable undercurls
	commentStyle = { italic = true },
	functionStyle = {},
	keywordStyle = { italic = true },
	statementStyle = { bold = true },
	typeStyle = {},
	variablebuiltinStyle = { italic = true },
	specialReturn = true, -- special highlight for the return keyword
	specialException = true, -- special highlight for exception handling keywords
	transparent = false, -- do not set background color
	dimInactive = false, -- dim inactive window `:h hl-NormalNC`
	globalStatus = true,
	terminalColors = true,
	colors = {},
	overrides = {
		FloatBorder = { bg = "NONE" },
	},
	theme = "default",
})
vim.cmd([[colorscheme kanagawa]])

-- Horizon
-- vim.cmd([[colorscheme horizon]])

-- Everblush
-- vim.cmd([[colorscheme everblush]])

-- Gruvbox
-- vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme gruvbox]])

-- Catppuccin
-- vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
-- require("catppuccin").setup()
-- vim.cmd([[colorscheme catppuccin]])

-- Nord
-- vim.cmd([[colorscheme nord]])
