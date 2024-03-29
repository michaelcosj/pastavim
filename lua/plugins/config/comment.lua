local ok, comment = pcall(require, "Comment")
if not ok then
  return
end

comment.setup({
  ignore = "^$",
  mappings = false,
})

-- keymaps
local keymap = require("core.utils").keymap
local opt = { expr = true, remap = true, replace_keycodes = false }

-- Toggle using count
keymap(
  "n",
  "gc",
  "v:count == 0 ? '<Plug>(comment_toggle_linewise_current)' : '<Plug>(comment_toggle_linewise_count)'",
  opt
)

-- Toggle in VISUAL mode
keymap("x", "gc", "<Plug>(comment_toggle_linewise_visual)")
keymap("x", "gC", "<Plug>(comment_toggle_blockwise_visual)")
