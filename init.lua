-- Safely call impatient to speed up loading plugins
local ok, impatient = pcall(require, "impatient")
if ok then
  impatient.enable_profile()
end

require("config.core")
require("config.plugins")
