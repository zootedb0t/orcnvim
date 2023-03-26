M = {}
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
    -- vim.opt.guicursor = vim.opt.guicursor + { "a:ver25-blink100" }  -- Verical cursor
    vim.opt.guicursor = vim.opt.guicursor + { "a:block-blink100" } -- Block cursor
  end,
})

-- Don't continue comments
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
  end,
})

-- Statusline
cmd({
  "WinEnter",
  "BufEnter",
  "CursorMoved",
  "CursorMovedI",
  "Filetype",
  "VimResized",
  "TabClosed",
  "TabEnter",
  "WinScrolled",
  "ModeChanged",
  "LspAttach",
}, {
  callback = function()
    local value = require("core.ui.statusline").draw()
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
cmd({
  "CursorHoldI",
  "BufModifiedSet",
  "CursorHold",
  "BufWinEnter",
  "BufFilePost",
  "InsertEnter",
  "BufWritePost",
  "TabClosed",
  "TabEnter",
}, {
  callback = function()
    local value = require("core.ui.winbar").draw()
    local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
    if not status_ok then
      return
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function(tbl)
    local set_offset = require("bufferline.api").set_offset

    local bufwinid
    local last_width
    local autocmd = vim.api.nvim_create_autocmd("WinScrolled", {
      callback = function()
        bufwinid = bufwinid or vim.fn.bufwinid(tbl.buf)

        local width = vim.api.nvim_win_get_width(bufwinid)
        if width ~= last_width then
          set_offset(width, "FileTree")
          last_width = width
        end
      end,
    })

    vim.api.nvim_create_autocmd("BufWipeout", {
      buffer = tbl.buf,
      callback = function()
        vim.api.nvim_del_autocmd(autocmd)
        set_offset(0)
      end,
      once = true,
    })
  end,
  pattern = "NvimTree", -- or any other filetree's `ft`
})

-- For transparency
function M.enable_tranparency()
  cmd("ColorScheme", {
    pattern = "*",
    callback = function()
      local hl_group = {
        "Normal",
        "SignColumn",
        "TelescopeBorder",
        "TelescopeNormal",
        "TelescopePromptNormal",
        "WhichKeyFloat",
        "NormalFloat",
        "NormalNC",
        "NvimTreeNormal",
        "NvimTreeNormalNC",
        "EndOfBuffer",
        "MsgArea",
        "VertSplit",
        "FloatBorder",
      }
      for _, name in ipairs(hl_group) do
        vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
      end
    end,
  })
end

return M
