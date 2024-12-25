return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "mason-lspconfig.nvim",
    },
    lazy = true,
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    opts = {
      ui = {
        border = "single",
        width = 0.7,
        height = 0.7,
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "saghen/blink.cmp" },
    lazy = true,
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "html",
          "cssls",
          "ts_ls",
          "clangd",
          "pyright",
          "lua_ls",
          -- hls ,
          "eslint",
          "bashls",
          -- "pylint",
          -- "djlint",
          "bashls",
        },
        handlers = {
          function(servers_name)
            require("lspconfig")[servers_name].setup({
              capabilities = capabilities,
            })
          end,
          lua_ls = function()
            require("lspconfig").lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = {
                    version = "LuaJIT",
                    path = (function()
                      local runtime_path = vim.split(package.path, ";")
                      table.insert(runtime_path, "lua/?.lua")
                      table.insert(runtime_path, "lua/?/init.lua")
                      return runtime_path
                    end)(),
                  },
                  diagnostics = {
                    globals = {
                      "vim",
                    },
                  },
                  workspace = {
                    maxPreload = 5000,
                    preloadFileSize = 10000,
                    library = {
                      vim.fn.expand("$VIMRUNTIME"),
                    },
                  },
                  hint = { enable = true },
                },
              },
            })
          end,
        },
      })
    end,
  },
}
