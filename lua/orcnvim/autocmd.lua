local cmd = vim.api.nvim_create_autocmd

-- Highlight on yank
cmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 200, on_visual = true })
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

-- Update statusline highlight.
cmd("ColorScheme", {
  callback = require("orcnvim.ui.highlight").statusline_highlight,
})

-- Enable tressitter features
cmd("FileType", {
  pattern = "*",
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- https://www.reddit.com/r/neovim/comments/1kzdd5x/restartlsp_but_for_native_vimlsp/
vim.api.nvim_create_user_command("LspRestart", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  vim.lsp.stop_client(clients, true)

  local timer = assert(vim.uv.new_timer())

  timer:start(500, 0, function()
    for _, _client in ipairs(clients) do
      vim.schedule_wrap(function(client)
        vim.lsp.enable(client.name)

        vim.cmd(":noautocmd write")
        vim.cmd(":edit")
      end)(_client)
    end
  end)
end, {})
