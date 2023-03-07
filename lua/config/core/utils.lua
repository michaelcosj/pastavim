local bit = require("bit")

local M = {}

function M.keymap(mode, keys, command, opts)
	opts = vim.tbl_deep_extend("force", { silent = true, noremap = true }, opts or {})
	vim.keymap.set(mode, keys, command, opts)
end

function M.get_hl_attr(hlgroup_name, attr, fallback)
	local exists, hl_table = pcall(vim.api.nvim_get_hl_by_name, hlgroup_name, true)
	if not exists then
		return fallback
	end

	if attr == "fg" and hl_table.foreground then
		return "#" .. bit.tohex(hl_table.foreground, 6)
	end
	if attr == "bg" and hl_table.background then
		return "#" .. bit.tohex(hl_table.background, 6)
	end

	return fallback
end

return M
