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
cmd({ "BufEnter", "CursorHoldI", "CursorHold", "WinResized", "WinEnter", "ModeChanged", "InsertEnter" }, {
  callback = function()
    local value = require("core.statusline").draw()
    local status_ok, _ = pcall(vim.api.nvim_set_option_value, "statusline", value, { scope = "global" })
    if not status_ok then
      return
    end
  end,
})

-- For suckless
cmd({ "BufWritePost" }, {
  pattern = ".Xresources",
  command = "!xrdb %",
})

-- Winbar
cmd(
  { "CursorHoldI", "CursorHold", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost", "TabClosed", "TabEnter" },
  {
    callback = function()
      local value = require("core.winbar").draw()
      local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
      if not status_ok then
        return
      end
    end,
  }
)
