local M = {}
local icon = require("core.icons")
local navic = require("nvim-navic")
local methods = vim.lsp.protocol.Methods
local map = vim.keymap.set

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

local function on_attach(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
  lsp_highlight(client, bufnr)
  -- disable_formatting(client)
end

M.capabilities = function()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
  end
end

M.setup = function()
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
  })

  -- Define signs-icons
  local signs = {
    ERROR = icon.diagnostics.Error,
    WARN = icon.diagnostics.Warning,
    INFO = icon.diagnostics.Information,
    HINT = icon.diagnostics.Hint,
  }

  vim.diagnostic.config({
    underline = false,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = signs.ERROR,
        [vim.diagnostic.severity.WARN] = signs.WARN,
        [vim.diagnostic.severity.INFO] = signs.INFO,
        [vim.diagnostic.severity.HINT] = signs.HINT,
      },
    },
    severity_sort = true,
    update_in_insert = false,
    virtual_text = false,
    float = {
      focusable = true,
      border = "single",
      source = "if_many",
      prefix = function(diag)
        local severity = vim.diagnostic.severity[diag.severity]
        return string.format(" %s ", signs[severity]), "Diagnostic" .. severity
      end,
    },
  })
  require("lspconfig.ui.windows").default_options.border = "single"
end

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Configure LSP On Attach",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    if client then
      if client.supports_method(methods.textDocument_codeAction) then
        map({ "n", "v" }, "<localleader>ca", vim.lsp.buf.code_action, { desc = "Code actions", buffer = bufnr })
      end

      if client.supports_method(methods.textDocument_rename) then
        map("n", "<localleader>rn", vim.lsp.buf.rename, { desc = "Rename", buffer = bufnr })
      end

      if client.supports_method(methods.textDocument_signatureHelp) then
        map("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help", buffer = bufnr })
      end

      if client.supports_method(methods.textDocument_declaration) then
        map("n", "gD", vim.lsp.buf.declaration, { desc = "Methods Declaration", buffer = bufnr })
      end

      if client.supports_method(methods.textDocument_definition) then
        map("n", "gd", vim.lsp.buf.definition, { desc = "Methods Definition", buffer = bufnr })
      end

      if client.supports_method(methods.textDocument_implementation) then
        map("n", "gi", vim.lsp.buf.implementation, { desc = "Implementation", buffer = bufnr })
      end

      if client.supports_method(methods.textDocument_typeDefinition) then
        map("n", "<localleader>D", vim.lsp.buf.type_definition, { desc = "Type Definition", buffer = bufnr })
      end

      if client.supports_method(methods.textDocument_hover) then
        map("n", "K", vim.lsp.buf.hover, { desc = "Hover", buffer = bufnr })
      end

      map("n", "<localleader>d", vim.diagnostic.open_float, { desc = "Open Diagnostic Float Window" })
      map("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic" })
      map("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
      map("n", "<localleader>q", vim.diagnostic.setloclist, { desc = "Show diagnostic in quickfix list" })
    end
    on_attach(client, bufnr)
  end,
})

return M
