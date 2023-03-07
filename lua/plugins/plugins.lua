local function load_config(plugin)
  local ok, _ = pcall(require, string.format("plugins.config.%s", plugin))
  if not ok then
    vim.notify("plugin: " .. plugin .. " not loaded")
  end
end

return {
  ----------[ Core ]----------
  --- Fancy syntax highlighting, indents, folding and stuff
  ---- https://github.com/nvim-treesitter/nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    config = function()
      load_config("treesitter")
    end
  },

  --- Show startup time infomation
  ---- https://github.com/dstein64/vim-startuptime
  "dstein64/vim-startuptime",

  --- Fix CursorHold autocmd
  ---- https://github.com/antoinemadec/FixCursorHold.nvim
  "antoinemadec/FixCursorHold.nvim",

  ----------[ Utility ]----------
  --- Never forget a keybind
  ---- https://github.com/folke/which-key.nvim
  {
    "folke/which-key.nvim",
    config = function()
      load_config("which-key")
    end
  },

  --- Auto pair delimiters
  ---- https://github.com/windwp/nvim-autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  --- Better buffer deletions
  ---- https://github.com/famiu/bufdelete.nvim
  "famiu/bufdelete.nvim",

  --- Turn lines to comments easily
  ---- https://github.com/numToStr/Comment.nvim
  { "numToStr/Comment.nvim",
    config = function()
      load_config("comment")
    end
  },

  --- Better navigation between neovim splits and tmux panes
  ---- https://github.com/numToStr/Navigator.nvim
  { 'numToStr/Navigator.nvim',
    config = function()
      require('Navigator').setup()
      local keymap = require("core.utils").keymap
      keymap('n', "<C-h>", '<CMD>NavigatorLeft<CR>')
      keymap('n', "<C-l>", '<CMD>NavigatorRight<CR>')
      keymap('n', "<C-k>", '<CMD>NavigatorUp<CR>')
      keymap('n', "<C-j>", '<CMD>NavigatorDown<CR>')
      keymap('n', "<C-p>", '<CMD>NavigatorPrevious<CR>')
    end },

  --- Fancy fuzzy finder
  ---- https://github.com/nvim-telescope/telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    tag = "0.1.0",
    config = function()
      load_config("telescope")
    end
    ,
  },

  --- Better fold
  ---- https://github.com/kevinhwang91/nvim-ufo
  { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async",
    config = function()
      load_config("ufo")
    end
  },

  --- Project management
  ---- https://github.com/ahmedkhalf/project.nvim
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        silent_chdir = false,
        patterns = { ".git", ".svn", "Makefile", "package.json" },
        ignore_lsp = { "sumneko_lua" },
      }
    end,
  },

  --- Better notifications
  ---- https://github.com/vigoux/notifier.nvim
  {
    "vigoux/notifier.nvim",
    config = function()
      require("notifier").setup()
    end,
  },

  --- Window picker d by neo-tree.nvim
  ---- https://github.com/s1n7ax/nvim-window-picker
  {
    "s1n7ax/nvim-window-picker",
    config = function()
      require("window-picker").setup()
    end,
  },

  --- File tree
  ---- https://github.com/nvim-neo-tree/neo-tree.nvim
  { "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      load_config("neo-tree")
    end
    ,
  },

  ----------[ UI & Apperance ]----------
  --- Improve the default vim.ui interfaces
  ----- https://github.com/stevearc/dressing.nvim
  { 'stevearc/dressing.nvim',
    config = function()
      load_config("dressing")
    end
  },

  --- Colourscheme
  ---- https://github.com/rebelot/kanagawa.nvim
  { "rebelot/kanagawa.nvim",
    config = function()
      load_config("colourscheme")
    end
  },

  --- Fancy icons for completions
  ---- https://github.com/onsails/lspkind.nvim
  "onsails/lspkind.nvim",

  --- Statusline
  ---- https://github.com/nvim-lualine/lualine.nvim
  { "nvim-lualine/lualine.nvim",
    config = function()
      load_config("lualine")
    end
  },

  --- Indent blank line
  ---- https://github.com/lukas-reineke/indent-blankline.nvim
  { "lukas-reineke/indent-blankline.nvim",
    config = function()
      load_config("indent-blankline")
    end
  },

  --- Dashboard
  ---- https://github.com/goolord/alpha-nvim
  { "goolord/alpha-nvim", dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      load_config("alpha")
    end
  },

  --- Bufferline
  ---- https://github.com/akinsho/bufferline.nvim
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      load_config("bufferline")
    end
    ,
  },

  ----------[ LSP, Linters and Completions]----------
  ---- https://github.com/williamboman/mason.nvim
  {
    "williamboman/mason.nvim",
    dependencies = {
      ---- https://github.com/williamboman/mason-lspconfig.nvim
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup {
        ui = {
          border = "rounded",
        }
      }
    end
  },

  ---- https://github.com/neovim/nvim-lspconfig
  { "neovim/nvim-lspconfig",
    config = function()
      load_config("lsp.config")
    end
  },


  --- For formatters and linters
  ---- https://github.com/jose-elias-alvarez/null-ls.nvim
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      load_config("lsp.null-ls")
    end
    ,
    dependencies = "jayp0521/mason-null-ls.nvim", ---- https://github.com/jayp0521/mason-null-ls.nvim
  },

  --- Show symbol when code actions are available
  ---- https://github.com/kosayoda/nvim-lightbulb
  {
    "kosayoda/nvim-lightbulb",
    dependencies = "antoinemadec/FixCursorHold.nvim",
    config = function()
      vim.cmd([[highlight LightbulbSignYellow guifg=LightYellow ctermfg=LightYellow]])
      vim.fn.sign_define("LightBulbSign", { texthl = "LightbulbSignYellow" },
        require("nvim-lightbulb").setup({
          sign = { enabled = true },
          autocmd = { enabled = true },
        }))
    end,
  },

  --- Show diagnostics and the like in a prettier quickfix like buffer
  ---- https://github.com/folke/trouble.nvim
  { "folke/trouble.nvim", dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      load_config("trouble")
    end
  },

  --- Show current code context on statusline/winbar
  ---- https://github.com/SmiteshP/nvim-navic
  { "SmiteshP/nvim-navic", dependencies = "neovim/nvim-lspconfig" },

  --- Completions
  ---- https://github.com/hrsh7th/nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    config = function()
      load_config("cmp")
    end
    ,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-cmdline",

      "f3fora/cmp-spell", ---- https://github.com/f3fora/cmp-spell
      "saadparwaiz1/cmp_luasnip", ---- https://github.com/saadparwaiz1/cmp_luasnip
    },
  },

  --- Snippets
  ---- https://github.com/L3MON4D3/LuaSnip
  ---- https://github.com/rafamadriz/friendly-snippets
  {
    "L3MON4D3/LuaSnip",
    tag = "v1.1.0",
    dependencies = { "rafamadriz/friendly-snippets" },
  },

  ----------[ GIT ]----------
  --- Git decorations
  ---- https://github.com/lewis6991/gitsigns.nvim
  { "lewis6991/gitsigns.nvim",
    config = function()
      load_config("gitsigns")
    end
  },

  --- Batteries included git helper
  ----https://github.com/TimUntersberger/neogit
  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    module = "neogit",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      load_config("neogit")
    end
    ,
  },
}
