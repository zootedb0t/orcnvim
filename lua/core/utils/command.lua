-- Change directory
vim.api.nvim_create_user_command("ChangeDirectory", function()
  vim.cmd([[lcd%:p:h]])
  vim.notify("Directory changed")
end, { desc = "Command to change directory" })

-- Toggle statusline
vim.api.nvim_create_user_command("ToggleStatusline", function()
  local statusline = vim.opt.laststatus:get() -- : is used to pass self as first-parameter
  if statusline == 3 then
    vim.opt.laststatus = 0
  elseif statusline == 0 then
    vim.opt.laststatus = 3
  end
end, { desc = "Toggle statusline" })

--- Change the number column between relative and fixed
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
      vim.cmd("cclose")
    else
      vim.cmd("horizontal botright copen") -- Open quickfix window horizontally
    end
  end
end, { desc = "Toggle Qucikfix" })
