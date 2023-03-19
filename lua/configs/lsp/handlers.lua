local M = {}
vim.g.maplocalleader = ","
local icon = require("core.icons")
local navic = require("nvim-navic")

function M.capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }
  return capabilities
end

M.setup = function()
  -- Overide handlers
  local signs = {
    Error = icon.diagnostics.BoldError,
    Warn = icon.diagnostics.BoldWarning,
    Info = icon.diagnostics.BoldInformation,
    Hint = icon.diagnostics.BoldHint,
  }
  for sign, symbol in pairs(signs) do
    vim.fn.sign_define("DiagnosticSign" .. sign, {
      text = symbol,
      texthl = "Diagnostic" .. sign,
      -- linehl = false,
      -- numhl = "Diagnostic" .. sign,
    })
  end

  vim.diagnostic.config({
    -- underline = true,
    signs = true,
    severity_sort = true,
    update_in_insert = false,
    virtual_text = false,
    -- virtual_text = {
    --   spacing = 10,
    -- severity_sort = "Error",
    -- },
    float = {
      focusable = false,
      style = "minimal",
      border = "single",
      source = "always",
      header = "Diagnostic",
      -- header = "",
    },
  })
end

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local bufopts = { buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<localleader>k", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<localleader>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<localleader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<localleader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  end,
})

local function lsp_highlight(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

local function disable_formatting(client)
  client.server_capabilities.documentFormattingProvider = false
end

M.on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
  lsp_highlight(client, bufnr)
  disable_formatting(client)
end

return M
