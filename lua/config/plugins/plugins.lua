------[[ Plugin Manager (packer) ]]------

-- Automatically install packer
local fn = vim.fn
local packer_bootstrap = false

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

--- Autocommand to install/update plugins on file save
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    autocmd BufWritePost */config/plugins/*.lua source <afile> | PackerCompile
  augroup end
]])

-- Safely require packer
local ok, packer = pcall(require, "packer")
if not ok then
  return
end

local function get_plugin_config(plugin)
  local ok, _ = pcall(require, string.format("config.plugins.%s", plugin))
  if not ok then
    vim.notify("plugin: " .. plugin .. " not loaded")
  end
end

return packer.startup({
  function(use)
    -- Plugin Manager manages itself
    ---- https://github.com/wbthomason/packer.nvim
    use("wbthomason/packer.nvim")

    ----------[ Core ]----------
    use({
      --- Fancy syntax highlighting, indents, folding and stuff
      ---- https://github.com/nvim-treesitter/nvim-treesitter
      { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = get_plugin_config("treesitter") },

      --- Speed up loading modules and improve startup time
      ---- https://github.com/lewis6991/impatient.nvim
      "lewis6991/impatient.nvim",

      --- Show startup time infomation
      ---- https://github.com/dstein64/vim-startuptime
      "dstein64/vim-startuptime",

      --- Fix CursorHold autocmd
      ---- https://github.com/antoinemadec/FixCursorHold.nvim
      "antoinemadec/FixCursorHold.nvim",
    })

    ----------[ Utility ]----------
    use({
      --- Never forget a keybind
      ---- https://github.com/folke/which-key.nvim
      { "folke/which-key.nvim", config = get_plugin_config("which-key") },

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
      { "numToStr/Comment.nvim", config = get_plugin_config("comment") },

      --- Better navigation between neovim splits and tmux panes
      ---- https://github.com/numToStr/Navigator.nvim
      { 'numToStr/Navigator.nvim',
        config = function()
          require('Navigator').setup()
          local keymap = require("config.core.utils").keymap
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
        requires = { { 'nvim-lua/plenary.nvim' } },
        cmd = "Telescope",
        tag = "0.1.0",
        config = get_plugin_config("telescope"),
      },

      --- Better fold
      ---- https://github.com/kevinhwang91/nvim-ufo
      { "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async", config = get_plugin_config("ufo") },

      --- Project management
      ---- https://github.com/ahmedkhalf/project.nvim
      {
        "ahmedkhalf/project.nvim",
        config = function()
          require("project_nvim").setup({
            silent_chdir = false,
            patterns = { ".git", ".svn", "Makefile", "package.json" },
            ignore_lsp = { "sumneko_lua" },
          })
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

      --- Window picker used by neo-tree.nvim
      ---- https://github.com/s1n7ax/nvim-window-picker
      {
        "s1n7ax/nvim-window-picker",
        tag = "v1.*",
        config = function()
          require("window-picker").setup()
        end,
      },

      --- File tree
      ---- https://github.com/nvim-neo-tree/neo-tree.nvim
      { "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons",
          "MunifTanjim/nui.nvim",
        },
        config = get_plugin_config("neo-tree"),
      },
    })

    ----------[ UI & Apperance ]----------
    use({
      --- Improve the default vim.ui interfaces
      ----- https://github.com/stevearc/dressing.nvim
      { 'stevearc/dressing.nvim', config = get_plugin_config("dressing") },

      --- Colourscheme
      ---- https://github.com/rebelot/kanagawa.nvim
      "rebelot/kanagawa.nvim",

      --- Fancy icons for completions
      ---- https://github.com/onsails/lspkind.nvim
      "onsails/lspkind.nvim",

      --- Statusline
      ---- https://github.com/nvim-lualine/lualine.nvim
      { "nvim-lualine/lualine.nvim", config = get_plugin_config("lualine") },

      --- Indent blank line
      ---- https://github.com/lukas-reineke/indent-blankline.nvim
      { "lukas-reineke/indent-blankline.nvim", config = get_plugin_config("indent-blankline") },

      --- Dashboard
      ---- https://github.com/goolord/alpha-nvim
      { "goolord/alpha-nvim", requires = { 'nvim-tree/nvim-web-devicons' }, config = get_plugin_config("alpha") },

      --- Bufferline
      ---- https://github.com/akinsho/bufferline.nvim
      {
        "akinsho/bufferline.nvim",
        tag = "v2.*",
        requires = "kyazdani42/nvim-web-devicons",
        config = get_plugin_config("bufferline"),
      },
    })

    ----------[ LSP and Completions]----------
    use({
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
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = get_plugin_config("lsp.null-ls"),
        requires = "jayp0521/mason-null-ls.nvim", ---- https://github.com/jayp0521/mason-null-ls.nvim
      },

      --- Show symbol when code actions are available
      ---- https://github.com/kosayoda/nvim-lightbulb
      {
        "kosayoda/nvim-lightbulb",
        requires = "antoinemadec/FixCursorHold.nvim",
        config = function()
          vim.cmd([[highlight LightbulbSignYellow guifg=LightYellow ctermfg=LightYellow]])
          vim.fn.sign_define("LightBulbSign", { texthl = "LightbulbSignYellow" })
          require("nvim-lightbulb").setup({
            sign = { enabled = true },
            autocmd = { enabled = true },
          })
        end,
      },

      --- Show diagnostics and the like in a prettier quickfix like buffer
      ---- https://github.com/folke/trouble.nvim
      { "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons", config = get_plugin_config("trouble") },

      --- Show current code context on statusline/winbar
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
        requires = { "rafamadriz/friendly-snippets" },
      },
    })

    ----------[ GIT ]----------
    use({
      --- Git decorations
      ---- https://github.com/lewis6991/gitsigns.nvim
      { "lewis6991/gitsigns.nvim", config = get_plugin_config("gitsigns") },

      --- Batteries included git helper
      ----https://github.com/TimUntersberger/neogit
      {
        "TimUntersberger/neogit",
        cmd = "Neogit",
        module = "neogit",
        requires = "nvim-lua/plenary.nvim",
        config = get_plugin_config("neogit"),
      },
    })

    -- Required to autoinstall packer
    if packer_bootstrap then
      require("packer").sync()
    end
  end,

  config = {
    display = {
      open_fn = function()
        -- Display in a popup window
        return require("packer.util").float({ border = "rounded" })
      end,
      prompt_border = "rounded",
    },
    profile = {
      -- Enable profiling
      enable = true,
      threshold = 1,
    },
  },
})
