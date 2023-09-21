local mason_ok, mason = pcall(require, "mason")
local masonlsp_ok, mason_lsp = pcall(require, "mason-lspconfig")
local servers = {
  html = {},
  cssls = {},
  tsserver = {},
  clangd = {},
  pyright = {},
  lua_ls = {
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
  hls = {},
}

if mason_ok then
  mason.setup({
    ui = {
      border = "single",
      width = 0.7,
      height = 0.8,
    },
  })
end

if masonlsp_ok then
  mason_lsp.setup({
    ensure_installed = vim.tbl_keys(servers),
    handlers = {
      function(servers_name)
        local opts = {
          capabilities = require("configs.lsp.handlers").capabilities(),
          on_attach = require("configs.lsp.handlers").on_attach,
          on_new_config = function(config)
            if servers_name == "clangd" then
              config.cmd = {
                "clangd",
                "--offset-encoding=utf-16",
              }
            end
          end,
          settings = servers[servers_name],
        }

        require("lspconfig")[servers_name].setup(opts)
      end,
    },
  })
end
