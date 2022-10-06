local ok, null_ls = pcall(require, "null-ls")
if not ok then
  return
end

local ok, mason_null_ls = pcall(require, "mason-null-ls")
if not ok then
  return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
  sources = {
    formatting.asmfmt,
    formatting.black,
    formatting.prettierd,
    null_ls.builtins.code_actions.gitsigns.with({
      disabled_filetypes = { "c", "cpp" },
    }),
  },
  on_attach = function(client, bufnr)
    local handler = require("config.plugins.lsp.handler")

    handler.common_keymaps(bufnr)

    handler.fmt_on_save(client)
  end,
})

mason_null_ls.setup({
  automatic_installation = true,
})
