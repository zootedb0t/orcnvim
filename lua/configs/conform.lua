local status_ok, conform = pcall(require, "conform")

if status_ok then
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
end
