return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "mason-lspconfig.nvim",
  },
  ft = require("core.utils").lint_filetype(),
  config = function()
    local null_ls = require("null-ls")
    local diagnostics = null_ls.builtins.diagnostics
    null_ls.setup({
      sources = {
        diagnostics.pylint,
        diagnostics.djlint,
      },
    })
  end,
}
