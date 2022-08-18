local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
	return
end

gitsigns.setup({
	signcolumn = true,
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		interval = 1000,
		follow_files = true,
	},
	attach_to_untracked = true,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
	},
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000, -- Disable if file is longer than this (in lines)
	preview_config = {
		-- Options passed to nvim_open_win
		border = "rounded",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns
		local keymap = require("config.core.utils").keymap

		-- Navigation
		keymap("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		keymap("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		-- Actions
		keymap({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>")
		keymap({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")

		keymap("n", "<leader>gS", gs.stage_buffer)
		keymap("n", "<leader>gu", gs.undo_stage_hunk)
		keymap("n", "<leader>gR", gs.reset_buffer)
		keymap("n", "<leader>gp", gs.preview_hunk)
		keymap("n", "<leader>gl", gs.toggle_current_line_blame)
		keymap("n", "<leader>gd", gs.diffthis)
		keymap("n", "<leader>td", gs.toggle_deleted)
	end,
})
