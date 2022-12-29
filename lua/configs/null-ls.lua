local M = {}

function M.config()
  local status_ok, null_ls = pcall(require, "null-ls")

  if status_ok then
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_action = null_ls.builtins.code_actions
    null_ls.setup({
      debug = false,
      diagnostics_format = "(#{s}) #{m}",
      sources = {
        formatting.stylua,
        -- diagnostics.luacheck,
        formatting.black.with({ extra_args = { "--fast" } }),
        -- diagnostics.pylint,
        -- formatting.clang_format,
        -- diagnostics.cppcheck,
        formatting.prettierd,
        code_action.eslint_d,
        diagnostics.shellcheck,
      },
    })
  end
end

return M
