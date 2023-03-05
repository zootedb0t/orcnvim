-- Source Lua file
vim.api.nvim_create_user_command("SourceFile", function()
  vim.cmd([[luafile %]])
  vim.cmd("echo 'File Reloaded'")
end, { desc = "Source Current Buffer" })

-- Change directory
vim.api.nvim_create_user_command("ChangeDirectory", function()
  vim.cmd([[lcd%:p:h]])
  vim.cmd("echo 'Directory changed'")
end, { desc = "Command to change directory" })

-- For peek.nvim
local status_ok, peek = pcall(require, "peek")
if status_ok then
  vim.api.nvim_create_user_command("PeekOpen", peek.open, {})
  vim.api.nvim_create_user_command("PeekClose", peek.close, {})
end

-- Toggle statusline
vim.api.nvim_create_user_command("ToggleStatusline", function()
  local statusline = vim.opt.laststatus:get() -- : is used to pass self as first-parameter
  if statusline == 3 then
    vim.opt.laststatus = 0
  elseif statusline == 0 then
    vim.opt.laststatus = 3
  end
end, { desc = "Toggle statusline" })
