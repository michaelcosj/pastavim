-- Kanagawa
local ok, kanagawa = pcall(require, "kanagawa")
if ok then
  kanagawa.setup({
    compile = false, -- enable compiling the colorscheme
    theme = "wave", -- Load "wave" theme when 'background' option is not set
    undercurl = false, -- enable undercurls
    globalStatus = true,
    background = { -- map the value of 'background' option to a theme
      dark = "dragon", -- try "dragon" !
      light = "lotus"
    },
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = "none"
          }
        }
      }
    },
    overrides = function(colors) -- add/modify highlights
      local theme = colors.theme
      return {
        FloatBorder = { bg = "NONE" },
        NormalFloat = { bg = "NONE" },
        TelescopeBorder = { bg = "NONE" },
        SpellBad = { undercurl = false },
        SpellCap = { undercurl = false },
        SpellLocal = { undercurl = false },
        SpellRare = { undercurl = false },
      }
    end,
  })
  vim.cmd.colorscheme("kanagawa")
end
