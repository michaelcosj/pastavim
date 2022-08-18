local status_ok, truezen = pcall(require, "true-zen")
if not status_ok then return end

truezen.setup {
  integrations = {
    tmux = false,
    twilight = true,
    lualine = true
  },
}

-- Keymaps
local keymap = require("config.core.utils").keymap

keymap('n', '<leader>zn', function()
  local first = 0
  local last = vim.api.nvim_buf_line_count(0)
  truezen.narrow(first, last)
end, { noremap = true })

keymap('v', '<leader>zn', function()
  local first = vim.fn.line('v')
  local last = vim.fn.line('.')
  truezen.narrow(first, last)
end, { noremap = true })

keymap('n', '<leader>zf', truezen.focus, { noremap = true })
keymap('n', '<leader>zm', truezen.minimalist, { noremap = true })
keymap('n', '<leader>za', truezen.ataraxis, { noremap = true })
