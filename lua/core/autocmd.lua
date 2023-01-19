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
cmd({ "BufEnter", "WinResized", "WinEnter", "ModeChanged" }, {
  callback = function()
    vim.o.statusline = require("core.statusline").draw()
  end,
})

-- For suckless
cmd({ "BufWritePost" }, {
  pattern = ".Xresources",
  command = "!xrdb %",
})
