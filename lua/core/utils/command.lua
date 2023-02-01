-- Source Lua file
vim.api.nvim_create_user_command("SourceFile", function()
  vim.cmd([[luafile %]])
  -- require("notify")("File Reloaded 勒勒")
  vim.cmd("echo 'File Reloaded'")
end, { desc = "Source Current Buffer" })

-- Change directory
vim.api.nvim_create_user_command("ChangeDirectory", function()
  vim.cmd([[lcd%:p:h]])
  -- require("notify")("Directory changed  ﱮ ")
  vim.cmd("echo 'Directory changed'")
end, { desc = "Command to change directory" })

-- For peek.nvim
local status_ok, peek = pcall(require, "peek")
if status_ok then
  vim.api.nvim_create_user_command("PeekOpen", peek.open, {})
  vim.api.nvim_create_user_command("PeekClose", peek.close, {})
end
