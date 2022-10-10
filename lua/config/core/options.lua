local opt = vim.opt

-- misc
opt.clipboard = "unnamedplus"
opt.completeopt = { "menuone", "noselect" }
opt.expandtab = true
opt.fileencoding = "utf-8"
opt.shiftwidth = 2
opt.smartcase = true
opt.smartindent = true
opt.spell = true
opt.spelllang = { "en_gb" }
opt.tabstop = 2
opt.shortmess:append("c")
opt.whichwrap:append("<,>,[,],h,l")

-- backup
opt.backup = false
opt.swapfile = false
opt.undofile = true
opt.writebackup = false

-- ui
opt.cmdheight = 1
opt.conceallevel = 0
opt.cursorline = true
opt.foldenable = false
opt.foldlevel = 2
opt.guifont = "monospace:h17"
opt.laststatus = 3
opt.mouse = "nv"
opt.number = true
opt.numberwidth = 4
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 8
opt.showmode = false
opt.showtabline = 2
opt.signcolumn = "yes"
opt.sidescrolloff = 8
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.wrap = false

-- search
opt.hlsearch = true
opt.ignorecase = true

-- perf
opt.timeoutlen = 500
opt.updatetime = 300
