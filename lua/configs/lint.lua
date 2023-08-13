local status_ok, lint = pcall(require, "lint")

if status_ok then
  lint.linters_by_ft = {
    python = {
      "pylint",
    },
    sh = {
      "shellcheck",
    },
    javascript = {
      "eslint_d",
    },
    typescript = {
      "eslint_d",
    },
    html = {
      "djlint",
    },
  }
end

vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
  callback = function()
    if status_ok then
      lint.try_lint()
    end
  end,
})
