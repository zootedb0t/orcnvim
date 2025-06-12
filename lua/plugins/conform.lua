return {
  "stevearc/conform.nvim",
  event = "LspAttach",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = {
        "ruff_fix",
        "ruff_format",
        "ruff_organize_imports",
      },
      javascript = { "prettierd" },
      sh = { "shfmt" },
      css = { "prettierd" },
      html = { "prettierd" },
      markdown = { "prettierd" },
      json = { "prettierd" },
      jsonc = { "prettierd" },
      htmldjango = { "djlint" },
    },
  },
}
