local ok, lualine = pcall(require, "lualine")
if not ok then
  return
end

local navic = require("nvim-navic")
local lazy_status = require("lazy.status")

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "kanagawa",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = {
      { "mode", separator = { left = '', right = '' } }
    },
    lualine_b = {
      "branch",
      "diff",
      { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
    },
    lualine_c = { "filename", "filetype" },
    lualine_x = {
      { navic.get_location, cond = navic.is_available },
    },
    lualine_y = {
      "progress",
      {
        lazy_status.updates,
        cond = lazy_status.has_updates,
        color = { fg = "#ff9e64" },
      },
    },
    lualine_z = {
      { "location", separator = { left = '', right = '' } }
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
