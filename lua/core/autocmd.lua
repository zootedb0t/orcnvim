local cmd = vim.api.nvim_create_autocmd

-- Highlight on yank
cmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200, on_visual = true })
  end,
  pattern = "*",
})

-- Fixing cursor
cmd("VimLeave", {
  pattern = "*",
  callback = function()
    vim.opt.guicursor = vim.opt.guicursor + { "a:ver25-blink100" }
  end,
})

-- Statusline
cmd({ "BufEnter", "WinResized" }, {
  callback = function()
    if vim.bo.filetype == "NvimTree" then
      return
    end
    vim.o.statusline = "%!luaeval('Statusline.active()')"
  end,
})

cmd({ "WinLeave", "BufLeave" }, {
  pattern = "*",
  callback = function()
    vim.o.statusline = "%!luaeval('Statusline.inactive()')"
  end,
})

cmd({ "WinEnter", "BufEnter", "FileType" }, {
  pattern = "NvimTree_1",
  callback = function()
    vim.o.statusline = "%!luaeval('Statusline.short()')"
  end,
})
