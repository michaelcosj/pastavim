local ok, null_ls = pcall(require, "null-ls")
if not ok then
  return
end

local ok, mason_null_ls = pcall(require, "mason-null-ls")
if not ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  sources = {
    -- Diagnostics
    diagnostics.mypy,
    diagnostics.flake8,

    -- Formatting
    formatting.prettierd,
    formatting.black,
  },
  on_attach = function(client, bufnr)
    local handler = require("plugins.config.lsp.handler")
    handler.common_keymaps(bufnr)
    handler.fmt_on_save(client)
  end,
})

mason_null_ls.setup({
  automatic_installation = true,
})
