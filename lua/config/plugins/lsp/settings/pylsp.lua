return {
  settings = {
    pylsp = {
      plugins = {
        pyflakes = {
          enabled = false,
        },
        yapf = {
          enabled = false,
        },
        flake8 = {
          enabled = true,
        },
        pycodestyle = {
          ignore = { 'W391' },
          maxLineLength = 100
        },
        jedi_completion = {
          fuzzy = true
        },
        -- third party plugins
        pylsp_mypy = {
          live_mode = true,
          overrides = { "--pretty", true },
        },
        black = {
          enabled = true
        }
      },
    }
  }
}
