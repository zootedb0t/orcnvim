local M = {}
vim.g.maplocalleader = ","
local icon = require("core.icons")
local navic = require("nvim-navic")
local methods = vim.lsp.protocol.Methods

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufopts = { buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    if client then
      if client.supports_method(methods.textDocument_definition) then
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
      end
      if client.supports_method(methods.textDocument_definition) then
        vim.keymap.set("n", "<localleader>k", vim.lsp.buf.signature_help, bufopts)
      end
      if client.supports_method(methods.textDocument_codeAction) then
        vim.keymap.set("n", "<localleader>rn", vim.lsp.buf.rename, bufopts)
      end
      if client.supports_method(methods.textDocument_codeAction) then
        vim.keymap.set({ "n", "v" }, "<localleader>ca", vim.lsp.buf.code_action, bufopts)
      end
      if client.supports_method(methods.textDocument_codeLens) then
        vim.keymap.set("n", "<localleader>cl", vim.lsp.codelens.run, bufopts)
      end
      if client.supports_method(methods.textDocument_implementation) then
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
      end
      if client.supports_method(methods.textDocument_typeDefinition) then
        vim.keymap.set("n", "<localleader>D", vim.lsp.buf.type_definition, bufopts)
      end
      if client.supports_method(methods.textDocument_references) then
        vim.keymap.set("n", "<localleader>r", vim.lsp.buf.references, bufopts)
      end
    end
    vim.keymap.set("n", "<localleader>d", vim.diagnostic.open_float, { desc = "Open Diagnostic Float Window" })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic" })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
    vim.keymap.set("n", "<localleader>q", vim.diagnostic.setloclist, { desc = "Show diagnostic in quickfix list" })
  end,
})

-- Highlight current word under cursor
local function lsp_highlight(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = "lsp_document_highlight",
    })
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      group = "lsp_document_highlight",
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
      buffer = bufnr,
      group = "lsp_document_highlight",
      callback = vim.lsp.buf.clear_references,
    })
  end
end

-- Disable lsp-server formatting. Instead use something like null-ls
-- local function disable_formatting(client)
--   client.server_capabilities.documentFormattingProvider = false
-- end

M.setup = function()
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
  })

  -- Overide handlers
  local signs = {
    Error = icon.diagnostics.BoldError,
    Warn = icon.diagnostics.BoldWarning,
    Info = icon.diagnostics.BoldInformation,
    Hint = icon.diagnostics.BoldHint,
  }
  for type, symbol in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {
      text = symbol,
      texthl = hl,
      numhl = hl,
    })
  end

  vim.diagnostic.config({
    underline = false,
    signs = true,
    severity_sort = true,
    update_in_insert = false,
    virtual_text = false,
    -- virtual_text = {
    -- virt_text_pos = "right_align",
    -- spacing = 10,
    -- severity_sort = "Error",
    -- },
    float = {
      focusable = true,
      border = "single",
      source = "if_many",
      prefix = function(diag)
        local severity_icon = {
          ERROR = signs.Error,
          WARN = signs.Warn,
          INFO = signs.Info,
          HINT = signs.Hint,
        }
        local severity = vim.diagnostic.severity[diag.severity]
        return string.format(" %s ", severity_icon[severity]), "Diagnostic" .. severity
      end,
    },
  })
  require("lspconfig.ui.windows").default_options.border = "single"
end

M.capabilities = function()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
  end
end

M.on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
  lsp_highlight(client, bufnr)
  -- disable_formatting(client)
end

return M
