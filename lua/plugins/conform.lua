local M = {}
local conform = require("conform")

function M.config()
  conform.setup({
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      javascript = { "prettierd" },
      sh = { "shfmt" },
      css = { "prettierd" },
      html = { "prettierd" },
      markdown = { "prettierd" },
      json = { "prettierd" },
      jsonc = { "prettierd" },
      htmldjango = { "djlint" },
    },
  })
end

function M.format()
  conform.format({ lsp_format = "fallback" })
end

return M
