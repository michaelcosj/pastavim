local keymap = require("core.utils").keymap

local M = {}

function M.init()
  -- Hover and signature help ui settings
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    width = 60,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    width = 60,
  })

  -- Diagnostics signs in gutter
  local signs = {
    DiagnosticSignError = " ",
    DiagnosticSignWarn = " ",
    DiagnosticSignHint = " ",
    DiagnosticSignInfo = " ",
  }
  for hl, icon in pairs(signs) do
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- Diagnostics settings
  vim.diagnostic.config({
    virtual_text = {
      prefix = "",
    },
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  })
end

function M.diagnostics_keymaps(_)
  keymap("n", "[d", vim.diagnostic.goto_prev, {})
  keymap("n", "]d", vim.diagnostic.goto_next, {})

  keymap("n", "<leader>xe", vim.diagnostic.open_float, {})

  keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", {})
  keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", {})

  keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", {})
  keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", {})
end

function M.common_keymaps(bufnr)
  local bufopts = { buffer = bufnr }
  keymap("n", "<leader>f", vim.lsp.buf.format, bufopts)
  keymap("v", "<leader>f", vim.lsp.buf.format, bufopts)
  keymap("n", "<leader>xa", vim.lsp.buf.code_action, bufopts)
  keymap("v", "<leader>xa", vim.lsp.buf.code_action, bufopts)
end

function M.lsp_keymaps(bufnr)
  local bufopts = { buffer = bufnr }
  keymap("n", "K", vim.lsp.buf.hover, bufopts)
  keymap("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)

  keymap("n", "gi", vim.lsp.buf.implementation, bufopts)
  keymap("n", "gD", vim.lsp.buf.declaration, bufopts)

  keymap("n", "gd", "<cmd>TroubleToggle lsp_definitions<cr>", bufopts)
  keymap("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", bufopts)
  keymap("n", "<leader>xD", "<cmd>TroubleToggle lsp_type_definitions<cr>", bufopts)

  keymap("n", "<leader>rn", vim.lsp.buf.rename, bufopts)

  keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)

  keymap("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)

  M.common_keymaps(bufnr)
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

function M.fmt_on_save(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
end

function M.auto_hover(bufnr)
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always",
        prefix = " ",
        scope = "cursor",
      }
      vim.diagnostic.open_float(nil, opts)
    end,
  })
end

return M
