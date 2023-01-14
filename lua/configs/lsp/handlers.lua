local M = {}

vim.g.maplocalleader = ","

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

M.setup = function()
  -- Overide handlers
  local signs = { Error = "", Warn = "▲", Info = "", Hint = "" }
  for sign, icon in pairs(signs) do
    vim.fn.sign_define("DiagnosticSign" .. sign, {
      text = icon,
      texthl = "Diagnostic" .. sign,
      -- linehl = false,
      -- numhl = "Diagnostic" .. sign,
    })
  end

  vim.diagnostic.config({
    -- underline = true,
    signs = true,
    severity_sort = true,
    update_in_insert = true,
    virtual_text = false,
    -- virtual_text = {
    --   spacing = 10,
    --   severity_sort = "Error",
    -- },
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      -- header = "Diagnostic",
      header = "",
    },
  })
end

local function lsp_keymap(bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<localleader>k", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<localleader>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<localleader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<localleader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
end

local function lsp_highlight(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "lsp_document_highlight",
      -- pattern = "<buffer>",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
      group = "lsp_document_highlight",
      -- pattern = "<buffer>",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

local function disable_formatting(client)
  if client.name == "clangd" then
    client.server_capabilities.documentFormattingProvider = false
  end
end

M.on_attach = function(client, bufnr)
  lsp_keymap(bufnr)
  lsp_highlight(client, bufnr)
  disable_formatting(client)
end

return M
