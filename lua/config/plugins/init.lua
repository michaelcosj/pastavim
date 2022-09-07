-- Safely call impatient to speed up loading plugins
local ok, impatient = pcall(require, "impatient")
if ok then
	impatient.enable_profile()
end

-- set colourscheme
require("config.plugins.colourscheme")

-- Initialize LSP handler
require("config.plugins.lsp.handler").init()

-- Plugins
require("config.plugins.plugins")
