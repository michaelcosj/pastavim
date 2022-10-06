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

	-- Turn off formating for some servers
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
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

mason_lspconfig.setup({
	ensure_installed = {
		"clangd",
		"bashls",
		"cssls",
		"gopls",
		"html",
		"jsonls",
		"marksman",
		"pyright",
		"sumneko_lua",
		"tsserver",
		"rust_analyzer",
	},
})

for _, server in pairs(mason_lspconfig.get_installed_servers()) do
	local server_opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	local has_custom_opts, server_custom_opts = pcall(require, "config.plugins.lsp.settings." .. server)
	if has_custom_opts then
		server_opts = vim.tbl_deep_extend("force", server_opts, server_custom_opts)
	end

	lspconfig[server].setup(server_opts)
end
