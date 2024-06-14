local mason = require("mason")
local mason_lsp = require("mason-lspconfig")
local capabilities = require("plugins.lsp.handlers").capabilities()
local servers = {
  html = {},
  cssls = {},
  tsserver = {},
  clangd = {},
  pyright = {},
  lua_ls = {},
  -- hls = {},
  eslint = {},
  bashls = {},
}

mason.setup({
  ui = {
    border = "single",
    width = 0.7,
    height = 0.7,
  },
})

mason_lsp.setup({
  ensure_installed = vim.tbl_extend("keep", vim.tbl_keys(servers), { "pylint", "djlint" }),
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
