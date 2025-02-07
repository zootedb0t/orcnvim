return {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    opts = {
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
    }
}
