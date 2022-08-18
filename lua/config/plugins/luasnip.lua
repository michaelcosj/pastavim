local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then return end

-- Load snippets from runtime path (for friendly snippets plugin) and custom path
require("luasnip.loaders.from_vscode").lazy_load()

local types = require("luasnip.util.types")

vim.api.nvim_set_hl(0, 'SnipOrange', { fg = "#EE5007" })
vim.api.nvim_set_hl(0, 'SnipBlue', { fg = "#006E7F" })

luasnip.config.setup({
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "●", "SnipOrange" } }
      }
    },
    [types.insertNode] = {
      active = {
        virt_text = { { "●", "SnipBlue" } }
      }
    }
  },
})
