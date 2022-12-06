-- Kanagawa
local ok, kanagawa = pcall(require, "kanagawa")
if ok then
  kanagawa.setup({
    undercurl = false, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    variablebuiltinStyle = { italic = true },
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    transparent = false, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    globalStatus = true,
    terminalColors = true,
    colors = {},
    overrides = {
      FloatBorder = { bg = "NONE" },
      NormalFloat = { bg = "NONE" },
      TelescopeBorder = { bg = "NONE" },
      SpellBad = { undercurl = false },
      SpellCap = { undercurl = false },
      SpellLocal = { undercurl = false },
      SpellRare = { undercurl = false },
    },
    theme = "default",
  })
  vim.cmd.colorscheme("kanagawa")
end
