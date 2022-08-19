local ok, comment = pcall(require, "Comment")
if not ok then
	return
end

comment.setup({
	ignore = "^$",
	mappings = false,

	pre_hook = function(ctx)
		-- Only calculate commentstring for tsx filetypes
		if vim.bo.filetype == "typescriptreact" then
			local U = require("Comment.utils")

			-- Determine whether to use linewise or blockwise commentstring
			local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

			-- Determine the location where to calculate commentstring from
			local location = nil
			if ctx.ctype == U.ctype.blockwise then
				location = require("ts_context_commentstring.utils").get_cursor_location()
			elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
				location = require("ts_context_commentstring.utils").get_visual_start_location()
			end

			return require("ts_context_commentstring.internal").calculate_commentstring({
				key = type,
				location = location,
			})
		end
	end,
})

-- keymaps
local keymap = require("config.core.utils").keymap
local opt = { expr = true, remap = true, replace_keycodes = false }

-- Toggle using count
keymap(
	"n",
	"<C-/>",
	"v:count == 0 ? '<Plug>(comment_toggle_linewise_current)' : '<Plug>(comment_toggle_linewise_count)'",
	opt
)

-- Toggle in VISUAL mode
keymap("x", "<C-/>", "<Plug>(comment_toggle_linewise_visual)")
keymap("x", "<C-c>", "<Plug>(comment_toggle_blockwise_visual)")
