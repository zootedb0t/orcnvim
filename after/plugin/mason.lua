local status_ok1, mason = pcall(require, "mason")
local status_ok2, mason_lsp = pcall(require,"mason-lspconfig")

if status_ok1 and status_ok2 then
  mason.setup()
  mason_lsp.setup()
end
