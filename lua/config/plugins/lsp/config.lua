---@diagnostic disable: redefined-local
local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end

local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok then
  return
end

local on_attach = function(client, bufnr)
  -- Init mappings on attach
  local handler = require("config.plugins.lsp.handler")
  handler.init()

  handler.lsp_keymaps(bufnr)
  handler.diagnostics_keymaps()

  handler.fmt_on_save(client, bufnr)

  -- Auto show diagnostics in hover window
  handler.auto_hover()

  -- codecontext on winbar
  local ok, navic = pcall(require, "nvim-navic")
  if ok then
    navic.attach(client, bufnr)
  end

  vim.notify("client " .. client.name .. " attached")
end

-- Autocomplete
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Servers to install
local servers = {
  "clangd",
  "bashls",
  "cssls",
  "gopls",
  "hls",
  "html",
  "jsonls",
  "marksman",
  "jedi_language_server",
  "sumneko_lua",
  "tsserver",
  "rust_analyzer",
}

mason_lspconfig.setup({
  ensure_installed = servers,
})

for _, server in pairs(servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  local has_custom_opts, custom_opts = pcall(require, "config.plugins.lsp.settings." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", opts, custom_opts)
  end

  lspconfig[server].setup(opts)
end
