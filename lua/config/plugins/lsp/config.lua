---@diagnostic disable: redefined-local
local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
	return
end

local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok then
	return
end

-- ServerName -> FormattingEnabled
local servers = {
	"asm_lsp",
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
}

local on_attach = function(client, bufnr)
	-- Init mappings on attach
	local handler = require("config.plugins.lsp.handler")
	handler.init()

	handler.lsp_keymaps(bufnr)
	handler.diagnostics_keymaps()

	-- Turn off formating for some servers
	local no_fmt_servers = {
		["asm_lsp"] = true,
		["cssls"] = true,
		["html"] = true,
		["jsonls"] = true,
		["marksman"] = true,
		["pyright"] = true,
		["sumneko_lua"] = true,
		["tsserver"] = true,
	}

	-- TODO: Remove this when you upgrade to 0.8
	if no_fmt_servers[client.name] then
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	else
		handler.fmt_keymaps(bufnr)
		handler.fmt_on_save(client, bufnr)
	end

	-- Auto show diagnostics in hover window
	handler.auto_hover()

	-- codecontext on winbar
	local ok, navic = pcall(require, "nvim-navic")
	if ok then
		navic.attach(client, bufnr)
	end

	print("client " .. client.name .. " attached")
end

-- Autocomplete
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

mason_lspconfig.setup({
	ensure_installed = servers,
})

for _, server in pairs(servers) do
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
