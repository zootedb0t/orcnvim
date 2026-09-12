local icon = require("orcnvim.icons").diagnostics
local map = vim.keymap.set

local severity = vim.diagnostic.severity
local signs = {
  [severity.ERROR] = icon.Error,
  [severity.WARN] = icon.Warning,
  [severity.HINT] = icon.Hint,
  [severity.INFO] = icon.Information,
}
local hl_map = {
  [severity.ERROR] = "DiagnosticError",
  [severity.WARN] = "DiagnosticWarn",
  [severity.HINT] = "DiagnosticHint",
  [severity.INFO] = "DiagnosticInfo",
}

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

vim.diagnostic.config({
  underline = false,
  signs = {
    text = {
      icon.Error,
      icon.Warning,
      icon.Information,
      icon.Hint,
    },
    numhl = {
      "ErrorMsg",
      "WarningMsg",
    },
  },
  severity_sort = true,
  float = {
    border = "rounded",
    source = "if_many",
  },
  -- Customize vim.diagnostic.show()
  status = {
    format = function(counts)
      local items = {}
      for level, _ in ipairs(vim.diagnostic.severity) do
        local count = counts[level]
        if count and count > 0 then
          table.insert(items, ("%%#%s#%s %s"):format(hl_map[level], signs[level], count))
        end
      end
      return table.concat(items, " ")
    end,
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Configure LSP On Attach",
  callback = function(args)
    local bufnr = args.buf
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local navic = require("nvim-navic")

    if client:supports_method("textDocument/typeDefinition") then
      map("n", "<localleader>D", vim.lsp.buf.type_definition, { desc = "Type Definition", buffer = bufnr })
    end

    if client:supports_method("textDocument/documentColor") then
      map({
        "n",
        "x",
      }, "grc", vim.lsp.document_color.color_presentation, { desc = "vim.lsp.document_color.color_presentation" })
    end

    if client:supports_method("textDocument/semanticTokens/full") then
      client.server_capabilities.semanticTokensProvider = nil
    end

    if client:supports_method("textDocument/documentSymbol") then
      navic.attach(client, bufnr)
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
  -- "pyright",
  "basedpyright",
  "bashls",
  "jsonls",
  "ruff",
})
