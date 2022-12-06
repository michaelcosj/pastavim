local ok, ts_conf = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

ts_conf.setup({
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "css",
    "dart",
    "go",
    "haskell",
    "help",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "pascal",
    "python",
    "rust",
    "scss",
    "svelte",
    "toml",
    "typescript",
    "yaml",
  },
  ignore_install = { "" },

  highlight = {
    enable = true,
    disable = { "" },
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  indent = { enable = true },
})
