local status_ok, conform = pcall(require, "conform")

if status_ok then
  conform.setup({
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_fallback = true,
      async = true,
    },
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      javascript = { "prettierd" },
      sh = { "shfmt" },
      css = { "prettierd" },
      html = { "prettierd" },
      markdown = { "prettierd" },
      c = { "clangformat" },
      cpp = { "clangformat" },
      json = { "prettierd" },
      ["*"] = { "trim_whitespace" },
    },
  })
end
