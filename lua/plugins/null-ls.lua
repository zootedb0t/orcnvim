local null_ls = require("null-ls")
local diagnostics = null_ls.builtins.diagnostics
null_ls.setup({
  sources = {
    diagnostics.pylint,
    diagnostics.shellcheck,
    diagnostics.eslint_d,
    diagnostics.djlint,
  },
})
