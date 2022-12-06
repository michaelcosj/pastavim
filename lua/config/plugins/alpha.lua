local ok, alpha = pcall(require, "alpha")
if not ok then
  return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
  [[ ██▓███   ▄▄▄        ██████ ▄▄▄█████▓ ▄▄▄    ██▒   █▓ ██▓ ███▄ ▄███▓]],
  [[▓██░  ██▒▒████▄    ▒██    ▒ ▓  ██▒ ▓▒▒████▄ ▓██░   █▒▓██▒▓██▒▀█▀ ██▒]],
  [[▓██░ ██▓▒▒██  ▀█▄  ░ ▓██▄   ▒ ▓██░ ▒░▒██  ▀█▄▓██  █▒░▒██▒▓██    ▓██░]],
  [[▒██▄█▓▒ ▒░██▄▄▄▄██   ▒   ██▒░ ▓██▓ ░ ░██▄▄▄▄██▒██ █░░░██░▒██    ▒██ ]],
  [[▒██▒ ░  ░ ▓█   ▓██▒▒██████▒▒  ▒██▒ ░  ▓█   ▓██▒▒▀█░  ░██░▒██▒   ░██▒]],
  [[▒▓▒░ ░  ░ ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░  ▒ ░░    ▒▒   ▓▒█░░ ▐░  ░▓  ░ ▒░   ░  ░]],
  [[░▒ ░       ▒   ▒▒ ░░ ░▒  ░ ░    ░      ▒   ▒▒ ░░ ░░   ▒ ░░  ░      ░]],
  [[░░         ░   ▒   ░  ░  ░    ░        ░   ▒     ░░   ▒ ░░      ░   ]],
  [[               ░  ░      ░                 ░  ░   ░   ░         ░   ]],
  [[                                                 ░                  ]],
}

dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("p", "  Projects", ":Telescope projects <CR>"),
  dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
  dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
  dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
  dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
  dashboard.button("q", "  Quit", ":qa<CR>"),
}

dashboard.section.footer.val = "- PastaVim by @michaelcosj -"

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
