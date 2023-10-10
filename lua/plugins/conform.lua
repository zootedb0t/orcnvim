local conform = require("conform")

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
    ["*"] = { "trim_whitespace" },
    htmldjango = { "djlint" },
  },
})
