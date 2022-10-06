-- Kanagawa
local ok, kanagawa = pcall(require, "kanagawa")
if ok then
  kanagawa.setup({
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    variablebuiltinStyle = { italic = true },
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    transparent = true, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    globalStatus = true,
    terminalColors = true,
    colors = {},
    overrides = {
      FloatBorder = { bg = "NONE" },
      NormalFloat = { bg = "NONE" },
      TelescopeBorder = { bg = "NONE" },
    },
    theme = "default",
  })
  vim.cmd([[colorscheme kanagawa]])
end
