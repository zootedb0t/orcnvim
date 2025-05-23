return {
  "nvimtools/none-ls.nvim",
  ft = require("orcnvim.utils").lint_filetype(),
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
