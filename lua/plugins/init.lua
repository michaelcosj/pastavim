local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- Initialize LSP handler
require("plugins.config.lsp.handler").init()

-- Setup package manager (lazy.nvim)
---- https://github.com/folke/lazy.nvim
require("lazy").setup(
  "plugins.plugins",
  {
    checker = {
      -- automatically check for plugin updates
      enabled = true,
      concurrency = nil, ---@type number? set to 1 to check for updates very slowly
      notify = true, -- get a notification when new updates are found
      frequency = 3600, -- check for updates every hour
    },
    defaults = {
      lazy = false, -- should plugins be lazy-loaded?
    },
    dev = {
      -- directory where you store your local plugin projects
      path = "~/Projects/Neovim",
    },
    ui = {
      border = "rounded"
    }
  }
)
