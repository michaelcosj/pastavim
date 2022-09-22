local ok, comment = pcall(require, "Comment")
if not ok then
	return
end

comment.setup({
	ignore = "^$",
	mappings = false,
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
