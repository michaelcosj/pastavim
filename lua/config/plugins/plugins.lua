local function get_plugin_config(plugin)
	require(string.format("config.plugins.%s", plugin))
end

return {
	----------[ Core ]----------
	--- Fancy syntax highlighting, indents, folding and stuff
	---- https://github.com/nvim-treesitter/nvim-treesitter
	{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = get_plugin_config("treesitter") },

	--- Neovim functions and utils required by some plugins
	---- https://github.com/nvim-lua/plenary.nvim
	"nvim-lua/plenary.nvim",

	--- Ui component library used by plugins like neo-tree.nvim
	---- https://github.com/MunifTanjim/nui.nvim
	"MunifTanjim/nui.nvim",

	--- Speed up loading modules and improve startup time
	---- https://github.com/lewis6991/impatient.nvim
	"lewis6991/impatient.nvim",

	--- Fancy dev icons
	---- https://github.com/kyazdani42/nvim-web-devicons
	"kyazdani42/nvim-web-devicons",

	--- Fix CursorHold autocmd
	---- https://github.com/antoinemadec/FixCursorHold.nvim
	"antoinemadec/FixCursorHold.nvim",

	----------[ Utility ]----------
	--- Never forget a keybind
	---- https://github.com/folke/which-key.nvim
	{ "folke/which-key.nvim", config = get_plugin_config("which-key") }, -- TODO,

	--- Auto pair delimiters
	---- https://github.com/windwp/nvim-autopairs
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	--- Better buffer deletions
	---- https://github.com/famiu/bufdelete.nvim
	"famiu/bufdelete.nvim",

	--- Turn lines to comments easily
	---- https://github.com/numToStr/Comment.nvim
	{ "numToStr/Comment.nvim", config = get_plugin_config("comment") },

	--- Treesitter plugin for setting commentstring based on cursor location
	---- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
	"JoosepAlviste/nvim-ts-context-commentstring",

	--- Fancy fuzzy finder
	---- https://github.com/nvim-telescope/telescope.nvim
	{ "nvim-telescope/telescope.nvim", tag = "0.1.0", config = get_plugin_config("telescope") },

	--- Better fold
	---- https://github.com/kevinhwang91/nvim-ufo
	{ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async", config = get_plugin_config("ufo") },

	--- Project management
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				manual_mode = true,
				silent_chdir = false,
			})
		end,
	},

	--- Better notifications
	---- https://github.com/rcarriga/nvim-notify
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				render = "minimal",
				background_colour = "#000000",
			})
			vim.notify = require("notify")
		end,
	},

	--- Window picker used by neo-tree.nvim
	---- https://github.com/s1n7ax/nvim-window-picker
	{
		"s1n7ax/nvim-window-picker",
		tag = "v1.*",
		config = function()
			require("window-picker").setup()
		end,
	},

	----------[ UI & Apperance ]----------
	--- Dashboard
	---- https://github.com/goolord/alpha-nvim
	{ "goolord/alpha-nvim", config = get_plugin_config("alpha") },

	--- Colourschemes
	---- https://github.com/lunarvim/horizon.nvim
	{ "lunarvim/horizon.nvim" },
	---- https://github.com/Everblush/everblush.nvim
	{ "Everblush/everblush.nvim", as = "everblush" },
	---- https://github.com/rebelot/kanagawa.nvim
	"rebelot/kanagawa.nvim",
	---- https://github.com/ellisonleao/gruvbox.nvim
	"ellisonleao/gruvbox.nvim",
	---- https://github.com/catppuccin/nvim
	{ "catppuccin/nvim", as = "catppuccin" },
	---- https://github.com/shaunsingh/nord.nvim
	"shaunsingh/nord.nvim",
	---- https://github.com/navarasu/onedark.nvim
	"navarasu/onedark.nvim",

	--- Fancy icons for completions
	---- https://github.com/onsails/lspkind.nvim
	"onsails/lspkind.nvim",

	--- Statusline
	---- https://github.com/nvim-lualine/lualine.nvim
	{ "nvim-lualine/lualine.nvim", config = get_plugin_config("lualine") },

	--- Bufferline
	---- https://github.com/akinsho/bufferline.nvim
	{
		"akinsho/bufferline.nvim",
		tag = "v2.*",
		requires = "kyazdani42/nvim-web-devicons",
		config = get_plugin_config("bufferline"),
	},

	--- Indent blank line
	---- https://github.com/lukas-reineke/indent-blankline.nvim
	{ "lukas-reineke/indent-blankline.nvim", config = get_plugin_config("indent-blankline") },

	--- File tree
	---- https://github.com/nvim-neo-tree/neo-tree.nvim
	{ "nvim-neo-tree/neo-tree.nvim", config = get_plugin_config("neo-tree"), branch = "v2.x" },

	--- Ahh... Zen, truly the place to be
	---- https://github.com/Pocco81/true-zen.nvim
	{ "Pocco81/true-zen.nvim", config = get_plugin_config("true-zen") },

	--- Dims inactive portions of code
	---- https://github.com/folke/twilight.nvim
	{
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup({
				dimming = {
					inactive = true,
				},
			})
		end,
	},

	----------[ LSP and Completions]----------
	--- LSP
	---- https://github.com/williamboman/mason.nvim
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
				},
			})
		end,
	},
	---- https://github.com/williamboman/mason-lspconfig.nvim
	"williamboman/mason-lspconfig.nvim",
	---- https://github.com/neovim/nvim-lspconfig
	{ "neovim/nvim-lspconfig", config = get_plugin_config("lsp.config") },

	--- For formatters and linters
	---- https://github.com/jose-elias-alvarez/null-ls.nvim
	{ "jose-elias-alvarez/null-ls.nvim", config = get_plugin_config("lsp.null-ls") },

	--- Floating code action menu
	---- https://github.com/weilbith/nvim-code-action-menu
	{ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" },

	--- Show symbol when code actions are available
	---- https://github.com/kosayoda/nvim-lightbulb
	{
		"kosayoda/nvim-lightbulb",
		requires = "antoinemadec/FixCursorHold.nvim",
		config = function()
			vim.cmd([[highlight LightbulbSignYellow guifg=LightYellow ctermfg=LightYellow]])
			vim.fn.sign_define(
				"LightBulbSign",
				{ text = "כֿ", texthl = "LightbulbSignYellow", linehl = "", numhl = "" }
			)

			require("nvim-lightbulb").setup({
				sign = { enabled = true },
				autocmd = { enabled = true },
			})
		end,
	},

	--- LSP renaming UI
	---- https://github.com/filipdutescu/renamer.nvim
	{ "filipdutescu/renamer.nvim", branch = "master", config = get_plugin_config("renamer") },

	--- Show diagnostics and the like in a prettier quickfix like buffer
	---- https://github.com/folke/trouble.nvim
	{ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons", config = get_plugin_config("trouble") },

	--- LSP document symbols outline
	---- https://github.com/simrat39/symbols-outline.nvim
	{ "simrat39/symbols-outline.nvim", config = get_plugin_config("symbols-outline") },

	--- Show current code context on winbar
	---- https://github.com/SmiteshP/nvim-navic
	{ "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" },

	--- Completions
	---- https://github.com/hrsh7th/nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		config = get_plugin_config("cmp"),
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-cmdline",

			---- https://github.com/saadparwaiz1/cmp_luasnip
			"saadparwaiz1/cmp_luasnip",
		},
	},

	--- Snippets
	---- https://github.com/L3MON4D3/LuaSnip
	"L3MON4D3/LuaSnip",
	---- https://github.com/rafamadriz/friendly-snippets
	"rafamadriz/friendly-snippets",

	----------[ GIT ]----------
	--- Git decorations
	---- https://github.com/lewis6991/gitsigns.nvim
	{ "lewis6991/gitsigns.nvim", config = get_plugin_config("gitsigns") },

	--- Batteries included git helper
	----https://github.com/TimUntersberger/neogit
	{ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim", config = get_plugin_config("neogit") },
}
