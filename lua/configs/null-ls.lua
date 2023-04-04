local null_ok, null_ls = pcall(require, "null-ls")
if null_ok then
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local code_action = null_ls.builtins.code_actions
  null_ls.setup({
    debug = false,
    diagnostics_format = "#{m}",
    sources = {
      formatting.stylua,
      -- diagnostics.luacheck,
      formatting.black.with({ extra_args = { "--fast" } }),
      -- diagnostics.pylint,
      -- formatting.clang_format,
      -- diagnostics.cppcheck,
      formatting.prettierd,
      -- code_action.eslint_d,
      code_action.eslint,
      -- diagnostics.eslint,
      diagnostics.shellcheck,
      formatting.shfmt,
      formatting.astyle.with({ extra_args = { "-A3", "-t8", "-p", "-xg", "-H", "-j", "-xB" } }),
    },
  })
end
