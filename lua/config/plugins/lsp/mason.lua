local status_ok, mason = pcall(require, "mason")
if not status_ok then
  print("did not load plugins/lsp/mason.lua")
  return
end

mason.setup({
  ui = {
    border = "rounded",
  },
})
