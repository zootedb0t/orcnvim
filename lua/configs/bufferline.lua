local status_ok, line = pcall(require, "bufferline")
require("core.ui.highlight").bufferline()

if status_ok then
  line.setup({
    animation = true,
    exclude_ft = { "" },
  })
end
