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

--- Change the number display modes
vim.api.nvim_create_user_command("ToggleNumber", function()
  local number = vim.wo.number -- local to window
  local relativenumber = vim.wo.relativenumber -- local to window
  if number and relativenumber then
    vim.wo.relativenumber = false
  elseif number then
    vim.wo.relativenumber = true
  end
end, { desc = "Toggle Number" })

-- Qucikfix window
vim.api.nvim_create_user_command("QuickFixToggle", function()
  local windows = vim.fn.getwininfo()
  for i = 1, vim.tbl_count(windows) do
    local tbl = windows[i]
    if tbl.quickfix == 1 then
      vim.cmd([[cclose]])
    else
      vim.cmd([[copen]])
    end
  end
end, { desc = "Toggle Qucikfix" })
