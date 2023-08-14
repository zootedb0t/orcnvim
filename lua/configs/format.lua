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
    },
  })
end
