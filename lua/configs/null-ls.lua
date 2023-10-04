local status_ok, null_ls = pcall(require, "null-ls")
if status_ok then
  local diagnostics = null_ls.builtins.diagnostics
  null_ls.setup({
    sources = {
      diagnostics.pylint,
      diagnostics.shellcheck,
      diagnostics.eslint_d,
      diagnostics.djlint,
    },
  })
end
