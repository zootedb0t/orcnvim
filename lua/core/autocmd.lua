local cmd = vim.api.nvim_create_autocmd

-- Highlight on yank
cmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200, on_visual = true })
  end,
  pattern = "*",
})

-- Fixing cursor
-- cmd("VimLeave", {
--   pattern = "*",
--   callback = function()
--     vim.opt.guicursor = vim.opt.guicursor + { "a:block-blink100" } -- Block cursor
--   end,
-- })

-- Don't continue comments
cmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
  end,
})

-- Equalize splites
cmd("VimResized", {
  callback = function()
    vim.cmd("wincmd =")
  end,
  desc = "Equalize Splits",
})

-- Disable diagnostic for rofi config
cmd("BufEnter", {
  pattern = "*.rasi",
  callback = function()
    vim.diagnostic.disable()
  end,
  desc = "No Lsp error for rofi config",
})

-- For suckless
cmd({ "BufWritePost" }, {
  pattern = ".Xresources",
  callback = function()
    vim.cmd("!xrdb %")
    vim.cmd("!pidof st | xargs kill -s USR1")
  end,
  desc = "Reload st terminal",
})

-- Update statusline highlight.
cmd("ColorScheme", {
  callback = require("core.ui.highlight").statusline_highlight,
})

-- Disable Semantic Token
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client then
--       client.server_capabilities.semanticTokensProvider = nil
--     end
--   end,
-- })
