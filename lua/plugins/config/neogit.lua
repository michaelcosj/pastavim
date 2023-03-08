local ok, neogit = pcall(require, "neogit")
if not ok then
  return
end

neogit.setup({
  -- Change the default way of opening neogit
  kind = "vsplit",
  -- Change the default way of opening the commit popup
  commit_popup = {
    kind = "split",
  },
  -- Change the default way of opening popups
  popup = {
    kind = "split",
  },
  -- customize displayed signs
  signs = {
    -- { CLOSED, OPENED }
    section = { ">", "v" },
    item = { ">", "v" },
    hunk = { "", "" },
  },

  -- override/add mappings
  mappings = {
    status = {
      ["<C-]>"] = "Toggle",
    },
  },
})
