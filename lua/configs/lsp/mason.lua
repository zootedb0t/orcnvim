local mason_ok, mason = pcall(require, "mason")
local masonlsp_ok, mason_lsp = pcall(require, "mason-lspconfig")
local servers = {
  html = {},
  cssls = {},
  tsserver = {},
  clangd = {},
  pyright = {},
  eslint = {},
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
          vim.api.nvim_get_runtime_file("", true),
          vim.fn.expand("$VIMRUNTIME/lua/"),
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

if mason_ok then
  mason.setup({
    ui = {
      border = "single",
    },
  })
end

if masonlsp_ok then
  mason_lsp.setup({
    ensure_installed = vim.tbl_keys(servers),
  })

  mason_lsp.setup_handlers({
    function(servers_name)
      local opts = {
        capabilities = require("configs.lsp.handlers").capabilities,
        on_attach = require("configs.lsp.handlers").on_attach,
        settings = servers[servers_name],
      }

      local status_ok, server = pcall(require, "configs.lsp.settings." .. servers_name)
      if status_ok then
        opts = vim.tbl_deep_extend("force", server, opts)
      end
      require("lspconfig")[servers_name].setup(opts)
    end,
  })
end
