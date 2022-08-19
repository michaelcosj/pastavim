local status_ok, ufo = pcall(require, "ufo")
if not status_ok then
	return
end

vim.o.foldcolumn = "1"
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
local keymap = require("config.core.utils").keymap

keymap("n", "zR", ufo.openAllFolds)
keymap("n", "zM", ufo.closeAllFolds)
keymap("n", "zk", ufo.peekFoldedLinesUnderCursor)

ufo.setup({
	provider_selector = function(_, _, _)
		return { "treesitter", "indent" }
	end,
})
