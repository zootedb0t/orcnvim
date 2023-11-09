local M = {}

function M.peek()
  require("peek").setup()
  vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
  vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
end

function M.treesitter_context()
  require("treesitter-context").setup({
    enable = false,
    zindex = 10,
  })
end

return M
