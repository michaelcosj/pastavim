local ok, bufferline = pcall(require, "bufferline")
if not ok then
	return
end

local kanagawa_dark_bg = "#16161D"

bufferline.setup({
	highlights = {
		fill = {
			bg = kanagawa_dark_bg,
		},
		background = {
			bg = kanagawa_dark_bg,
			italic = true,
		},
		numbers = {
			bg = kanagawa_dark_bg,
		},
		close_button = {
			bg = kanagawa_dark_bg,
		},
		indicator_selected = {
			fg = "#938AA9",
		},
	},

	options = {
		numbers = "ordinal",
		close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
		right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
		middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
		-- NOTE: this plugin is designed with this icon in mind,
		-- and so changing this is NOT recommended, this is intended
		-- as an escape hatch for people who cannot bear it for whatever reason
		indicator_icon = "▎",
		buffer_close_icon = "",
		modified_icon = "●",
		close_icon = "",

		left_trunc_marker = "",
		right_trunc_marker = "",

		max_name_length = 20,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		tab_size = 15,

		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = false,
		diagnostics_indicator = nil,

		offsets = {
			{
				filetype = "neo-tree",
				text = "NeoTree",
				padding = 1,
				highlight = "Title",
				text_align = "left",
			},
		},

		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = false,
		show_tab_indicators = true,
		persist_buffer_sort = false,
		separator_style = { "", "" },
		enforce_regular_tabs = true,
		always_show_bufferline = true,

		custom_areas = nil,
	},
})

-- Keymaps
local keymap = require("config.core.utils").keymap

keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", {})
keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", {})

for i = 1, 9 do
	keymap("n", ("<Leader>%s"):format(i), ("<cmd>lua require('bufferline').go_to_buffer(%s, true)<cr>"):format(i), {})
end
keymap("n", "<Leader>$", "<cmd>lua require('bufferline').go_to_buffer(-1, true)<cr>", {})

keymap("n", "<Leader>0", "<cmd>BufferLinePick<cr>", {})
