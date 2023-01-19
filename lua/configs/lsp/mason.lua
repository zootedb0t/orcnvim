local status_ok1, mason = pcall(require, "mason")
local status_ok2, mason_lsp = pcall(require, "mason-lspconfig")
local servers = {
  html = {},
  cssls = {},
  tsserver = {},
  clangd = {},
  pyright = {},
  sumneko_lua = {
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

if status_ok1 then
  mason.setup({
    ui = {
      border = "single",
    },
  })
end

if status_ok2 then
  mason_lsp.setup({
    ensure_installed = vim.tbl_keys(servers),
  })

  mason_lsp.setup_handlers({
    function(servers_name)
      require("lspconfig")[servers_name].setup({
        capabilities = require("configs.lsp.handlers").capabilities,
        on_attach = require("configs.lsp.handlers").on_attach,
        settings = servers[servers_name],
      })
    end,
  })
end
