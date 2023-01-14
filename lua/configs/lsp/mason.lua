local status_ok1, mason = pcall(require, "mason")
local status_ok2, mason_lsp = pcall(require, "mason-lspconfig")
local servers = {
  html = {},
  cssls = {},
  tsserver = {},
  clangd = {},
  pyright = {},
  sumneko_lua = {},
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
    ensure_installed = servers,
  })

  mason_lsp.setup_handlers({
    function(servers_name)
      local opts = {
        on_attach = require("configs.lsp.handlers").on_attach,
        capabilities = require("configs.lsp.handlers").capabilities,
      }

      local require_ok, server = pcall(require, "configs.lsp.settings." .. servers_name)
      if require_ok then
        opts = vim.tbl_deep_extend("force", server, opts)
      end
      require("lspconfig")[servers_name].setup(opts)
    end,
  })
end
