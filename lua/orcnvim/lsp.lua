local icon = require("orcnvim.icons")
local map = vim.keymap.set

-- Highlight current word under cursor
local function lsp_references_highlight(client, bufnr)
  if client:supports_method("textDocument/documentHighlight") then
    vim.api.nvim_create_augroup("lsp_references_highlight", { clear = false })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "lsp_references_highlight",
      desc = "Highlight references under the cursor",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
      group = "lsp_references_highlight",
      desc = "Clear highlight references",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover({
  border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.buf.signature_help({
  border = "single",
})

vim.diagnostic.config({
  underline = false,
  signs = {
    text = {
      icon.diagnostics.Error,
      icon.diagnostics.Warning,
      icon.diagnostics.Information,
      icon.diagnostics.Hint,
    },
  },
  severity_sort = true,
  float = {
    border = "single",
    source = "if_many",
  },
  jump = { float = true },
})

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Configure LSP On Attach",
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local navic = require("nvim-navic")
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    if client then
      if client:supports_method("textDocument/typeDefinition") then
        map("n", "<localleader>D", vim.lsp.buf.type_definition, { desc = "Type Definition", buffer = bufnr })
      end

      if client:supports_method("textDocument/documentColor") then
        vim.lsp.document_color.enable(true, args.buf)
      end

      if client:supports_method("textDocument/semanticTokens/full") then
        client.server_capabilities.semanticTokensProvider = nil
      end

      if client:supports_method("textDocument/documentSymbol") then
        navic.attach(client, bufnr)
      end
    end

    lsp_references_highlight(client, bufnr)
    map("n", "<localleader>q", vim.diagnostic.setloclist, { desc = "Show diagnostic in quickfix list" })
  end,
})

-- Enable LSP
vim.lsp.enable({
  "lua_ls",
  "cssls",
  "html",
  "ts_ls",
  "clangd",
  "pyright",
  "bashls",
  "jsonls",
})
