local status_ok, ts_conf = pcall(require, "nvim-treesitter.configs")
if not status_ok then
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

	context_commentstring = {
		enable = true,
		enable_autocmd = false,
		config = {
			css = "// %s",
		},
	},

	indent = { enable = true },
})
