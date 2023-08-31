local status_ok, format = pcall(require, "formatter")

if status_ok then
  format.setup({
    filetype = {
      python = {
        require("formatter.filetypes.python").black,
      },
      sh = {
        require("formatter.filetypes.sh").shfmt,
      },
      css = {
        require("formatter.filetypes.css").prettierd,
      },
      html = {
        require("formatter.filetypes.html").prettierd,
      },
      lua = {
        require("formatter.filetypes.lua").stylua,
      },
      htmldjango = {
        function()
          return {
            exe = "djlint",
            args = {
              "--reformat",
              "-",
            },
            stdin = true,
          }
        end,
      },
      markdown = {
        require("formatter.filetypes.markdown").prettierd,
      },
      c = {
        require("formatter.filetypes.c").clangformat,
      },
      cpp = {
        require("formatter.filetypes.c").clangformat,
      },
      javascript = {
        require("formatter.filetypes.javascript").prettierd,
      },
      json = {
        require("formatter.filetypes.javascript").prettierd,
      },
    },
  })
end
