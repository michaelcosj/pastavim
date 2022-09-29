-- TODO
local ok, alpha = pcall(require, "alpha")
if not ok then
	return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
[[                                             |||        ]],
[[                                             |||||,     ]],
[[                                            \|||||/     ]],
[[           /)                               `|||||/     ]],
[[      ,-""//-. ______                       |`"""'|     ]],
[[   ==|`-.//.-'|,-----'======================|  P  |==== ]],
[[     |        |---,---,  .---,((--------.   |  A  |     ]],
[[     |        |  /(_)/  /   (()))` ;'", \   |  S  |     ]],
[[     `-.____.-' /_  /  /  /| `;',`;; ,/( \  |  T  |     ]],
[[               /(_)/  /  //  ; ` "  ((()) \ |  A  |     ]],
[[     .-::-.   /_  /  /  /)   "' ;" ; `;"'  \`-...-'     ]],
[[    (::::::) /(_)/   `=//===================' nvim      ]],
[[     `-::-' /   /     (/                                ]],
[[ ----------'---'                                        ]],
}

dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
	dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
	dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

-- local function footer()
-- 	return "Let's All Love Lain"
-- end

dashboard.section.footer.val = "PastaVim"

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true

alpha.setup(dashboard.opts)

--- Autocommand
vim.cmd([[
  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end
]])
