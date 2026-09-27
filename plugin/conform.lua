local conform_loaded = false

local function conform_load()
  if not conform_loaded then
    vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = {
          "ruff_fix",
          "ruff_format",
          "ruff_organize_imports",
        },
        javascript = { "prettierd" },
        sh = { "shfmt" },
        css = { "prettierd" },
        html = { "prettierd" },
        markdown = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        htmldjango = { "djlint" },
        kdl = { "kdlfmt" },
      },
    })
    conform_loaded = true
  end
  require("conform").format()
end

vim.keymap.set("n", "<leader>lf", conform_load, { desc = "Format buffer" })
