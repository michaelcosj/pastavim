local ok, null_ls = pcall(require, "null-ls")
if not ok then
	return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
	sources = {
		formatting.asmfmt,
		formatting.black,
		formatting.stylua,
		formatting.prettierd,
		null_ls.builtins.code_actions.gitsigns.with({
			disabled_filetypes = { "c", "cpp" },
		}),
	},
	on_attach = function(client, bufnr)
		local handler = require("config.plugins.lsp.handler")
		handler.init()

		handler.fmt_keymaps(bufnr)
		handler.fmt_on_save(client)

		require("config.core.utils").keymap("n", "<leader>xa", "<cmd>CodeActionMenu<CR>", { buffer = bufnr })
	end,
})
