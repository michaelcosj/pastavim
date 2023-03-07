-- options
local opt = vim.opt

opt.clipboard = "unnamedplus"
opt.conceallevel = 0
opt.mouse = "nv"
opt.scrolloff = 8
opt.showmode = false
opt.showtabline = 2
opt.sidescrolloff = 8
opt.smartcase = true
opt.spell = true
opt.spelllang = { "en_gb" }
opt.splitbelow = true
opt.splitright = true
opt.whichwrap:append("<,>,[,],h,l")
opt.wrap = false
opt.ignorecase = true
opt.timeoutlen = 500
opt.updatetime = 300

-- keymaps
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("", "<Space>", "<Nop>", {})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- save files
keymap("n", "<leader>w", ":Write<CR>", opts)

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
