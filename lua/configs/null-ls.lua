local null_ok, null_ls = pcall(require, "null-ls")
if null_ok then
  local formatting = null_ls.builtins.formatting
  null_ls.setup({
    debug = false,
    diagnostics_format = "#{m}",
    sources = {
      formatting.stylua,
      formatting.black.with({ extra_args = { "--fast" } }),
      formatting.djlint,
      formatting.prettierd,
      formatting.shfmt,
      formatting.astyle.with({ extra_args = { "-A3", "-t8", "-p", "-xg", "-H", "-j", "-xB" } }),
    },
  })
end
