return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "SmiteshP/nvim-navic",
    "mason-lspconfig.nvim",
    "saghen/blink.cmp",
  },
  ft = require("orcnvim.utils").lsp_filetype(),
  config = function()
    local icon = require("orcnvim.icons")
    local navic = require("nvim-navic")
    local methods = vim.lsp.protocol.Methods
    local map = vim.keymap.set

    -- Highlight current word under cursor
    local function lsp_references_highlight(client, bufnr)
      if client.supports_method(methods.textDocument_documentHighlight) then
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

    local function on_attach(client, bufnr)
      if client.supports_method(methods.textDocument_documentSymbol) then
        navic.attach(client, bufnr)
      end
      lsp_references_highlight(client, bufnr)
      -- disable_formatting(client)
    end

    vim.lsp.handlers[methods.textDocument_hover] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "single",
    })

    vim.lsp.handlers[methods.textDocument_signatureHelp] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "single",
    })

    -- Define lsp signs
    local lsp_signs = {
      ERROR = icon.diagnostics.Error,
      WARN = icon.diagnostics.Warning,
      INFO = icon.diagnostics.Information,
      HINT = icon.diagnostics.Hint,
    }

    vim.diagnostic.config({
      underline = false,
      signs = {
        text = {
          lsp_signs.ERROR,
          lsp_signs.WARN,
          lsp_signs.INFO,
          lsp_signs.HINT,
        },
      },
      severity_sort = true,
      update_in_insert = false,
      virtual_text = false,
      float = {
        border = "single",
        source = "if_many",
        prefix = function(diag)
          local severity = vim.diagnostic.severity[diag.severity]
          return string.format(" %s ", lsp_signs[severity]), "Diagnostic" .. severity
        end,
      },
      jump = { float = true },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "Configure LSP On Attach",
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        if client then
          if client.supports_method(methods.textDocument_typeDefinition) then
            map("n", "<localleader>D", vim.lsp.buf.type_definition, { desc = "Type Definition", buffer = bufnr })
          end

          map("n", "<localleader>q", vim.diagnostic.setloclist, { desc = "Show diagnostic in quickfix list" })
        end
        on_attach(client, bufnr)
      end,
    })
  end,
}
