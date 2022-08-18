local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

local get_hex = require("config.core.utils").get_hl_attr

local err_hl = get_hex("DiagnosticError", "fg", "#e55666")
local warn_hl = get_hex("DiagnosticWarn", "fg", "#f6d634")
local hint_hl = get_hex("DiagnosticHint", "fg", "#65e566")
local info_hl = get_hex("DiagnosticInfo", "fg", "#324232")

local kanagawa_dark_bg = "#16161D"

bufferline.setup({
	highlights = {
		fill = {
			bg = kanagawa_dark_bg,
			-- bg = "bg"
		},
		background = {
			bg = kanagawa_dark_bg,
			-- bg = "bg"
			italic = true,
		},
		numbers = {
			bg = kanagawa_dark_bg,
			-- bg = "bg"
		},
		separator = {
			-- fg = "bg",
			bg = kanagawa_dark_bg,
			-- bg = "bg",
		},
		close_button = {
			-- bg = "bg",
			bg = kanagawa_dark_bg,
		},
		indicator_visible = {
			bg = "bg",
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
		-- separator_style = { "", "" },
		-- separator_style = { "", "" },
		separator_style = "thin",
		enforce_regular_tabs = true,
		always_show_bufferline = true,

		custom_areas = {
			right = function()
				local result = {}
				local seve = vim.diagnostic.severity
				local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
				local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
				local info = #vim.diagnostic.get(0, { severity = seve.INFO })
				local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

				if error ~= 0 then
					table.insert(result, { text = "  " .. error, fg = err_hl })
				end

				if warning ~= 0 then
					table.insert(result, { text = "  " .. warning, fg = warn_hl })
				end

				if hint ~= 0 then
					table.insert(result, { text = "  " .. hint, fg = hint_hl })
				end

				if info ~= 0 then
					table.insert(result, { text = "  " .. info, fg = info_hl })
				end
				return result
			end,
		},
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
