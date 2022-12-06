-- Shorten function name
local keymap = require("config.core.utils").keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", {})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core Keymaps {{
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", {})
keymap("n", "<C-j>", "<C-w>j", {})
keymap("n", "<C-k>", "<C-w>k", {})
keymap("n", "<C-l>", "<C-w>l", {})

-- Move text up and down normal mode
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==g", {})
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==g", {})

-- Move text up and down visual mode
keymap("v", "<A-j>", ":m .+1<CR>==", {})
keymap("v", "<A-k>", ":m .-2<CR>==", {})

-- Move text up and down visual block
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", {})
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", {})

-- Indent visual selection easily
keymap("v", "<", "<gv", {})
keymap("v", ">", ">gv", {})

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", {})
keymap("n", "<C-Down>", ":resize +2<CR>", {})
keymap("n", "<C-Left>", ":vertical resize -2<CR>", {})
keymap("n", "<C-Right>", ":vertical resize +2<CR>", {})

-- Saving files
keymap("n", "<leader>w", ":w<CR>", {})

-- Better paste? (NOTE Not sure what exactly it does though)
keymap("v", "p", '"_dP', {})
-- }}
