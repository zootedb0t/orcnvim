local icon = require("orcnvim.icons")
local navic = require("nvim-navic")
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

local function on_attach(client, bufnr)
  if client:supports_method("textDocument/documentSymbol") then
    navic.attach(client, bufnr)
  end
  lsp_references_highlight(client, bufnr)
  -- disable_formatting(client)
end

-- vim.lsp.handlers[methods.textDocument_hover] = vim.lsp.with(vim.lsp.handlers.hover, {
vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover({
  border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.buf.signature_help({
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
      if client:supports_method("textDocument/typeDefinition") then
        map("n", "<localleader>D", vim.lsp.buf.type_definition, { desc = "Type Definition", buffer = bufnr })
      end

      if client:supports_method("textDocument/documentColor") then
        vim.lsp.document_color.enable(true, args.buf)
      end

      map("n", "<localleader>q", vim.diagnostic.setloclist, { desc = "Show diagnostic in quickfix list" })
    end
    on_attach(client, bufnr)
  end,
})

-- INFO lua-language-server config
vim.lsp.config["luals"] = {
  cmd = { "lua-language-server" },
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
  filetypes = { "lua" },
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
}
vim.lsp.enable("luals")

-- INFO css-language-server config
vim.lsp.config["cssls"] = {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
  root_markers = { "package.json", ".git" },
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
}
vim.lsp.enable("cssls")

-- INFO html-language-server config
vim.lsp.config["html"] = {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "templ" },
  root_markers = { "package.json", ".git" },
  settings = {},
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { "html", "css", "javascript" },
  },
}
vim.lsp.enable("html")

-- INFO ts-langugage-server config
vim.lsp.config["ts_ls"] = {
  init_options = { hostInfo = "neovim" },
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
  handlers = {
    -- handle rename request for certain code actions like extracting functions / types
    ["_typescript.rename"] = function(_, result, ctx)
      local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
      vim.lsp.util.show_document({
        uri = result.textDocument.uri,
        range = {
          start = result.position,
          ["end"] = result.position,
        },
      }, client.offset_encoding)
      vim.lsp.buf.rename()
      return vim.NIL
    end,
  },
  on_attach = function(client)
    -- ts_ls provides `source.*` code actions that apply to the whole file. These only appear in
    -- `vim.lsp.buf.code_action()` if specified in `context.only`.
    vim.api.nvim_buf_create_user_command(0, "LspTypescriptSourceAction", function()
      local source_actions = vim.tbl_filter(function(action)
        return vim.startswith(action, "source.")
      end, client.server_capabilities.codeActionProvider.codeActionKinds)

      vim.lsp.buf.code_action({
        context = {
          only = source_actions,
        },
      })
    end, {})
  end,
}
vim.lsp.enable("ts_ls")

-- INFO clangd-language-server config
local function symbol_info()
  local bufnr = vim.api.nvim_get_current_buf()
  local clangd_client = vim.lsp.get_clients({ bufnr = bufnr, name = "clangd" })[1]
  if not clangd_client or not clangd_client.supports_method("textDocument/symbolInfo") then
    return vim.notify("Clangd client not found", vim.log.levels.ERROR)
  end
  local win = vim.api.nvim_get_current_win()
  local params = vim.lsp.util.make_position_params(win, clangd_client.offset_encoding)
  clangd_client.request("textDocument/symbolInfo", params, function(err, res)
    if err or #res == 0 then
      -- Clangd always returns an error, there is not reason to parse it
      return
    end
    local container = string.format("container: %s", res[1].containerName) ---@type string
    local name = string.format("name: %s", res[1].name) ---@type string
    vim.lsp.util.open_floating_preview({ name, container }, "", {
      height = 2,
      width = math.max(string.len(name), string.len(container)),
      focusable = false,
      focus = false,
      border = "single",
      title = "Symbol Info",
    })
  end, bufnr)
end

local function switch_source_header(bufnr)
  local method_name = "textDocument/switchSourceHeader"
  local client = vim.lsp.get_clients({ bufnr = bufnr, name = "clangd" })[1]
  if not client then
    return vim.notify(("method %s is not supported by any servers active on the current buffer"):format(method_name))
  end
  local params = vim.lsp.util.make_text_document_params(bufnr)
  client.request(method_name, params, function(err, result)
    if err then
      error(tostring(err))
    end
    if not result then
      vim.notify("corresponding file cannot be determined")
      return
    end
    vim.cmd.edit(vim.uri_to_fname(result))
  end, bufnr)
end

vim.lsp.config["clangd"] = {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_markers = {
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac", -- AutoTools
    ".git",
  },
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { "utf-8", "utf-16" },
  },
  on_attach = function()
    vim.api.nvim_buf_create_user_command(0, "LspClangdSwitchSourceHeader", function()
      switch_source_header(0)
    end, { desc = "Switch between source/header" })

    vim.api.nvim_buf_create_user_command(0, "LspClangdShowSymbolInfo", function()
      symbol_info()
    end, { desc = "Show symbol info" })
  end,
}
vim.lsp.enable("clangd")

-- pyright-language-server config
local function set_python_path(path)
  local clients = vim.lsp.get_clients({
    bufnr = vim.api.nvim_get_current_buf(),
    name = "pyright",
  })
  for _, client in ipairs(clients) do
    if client.settings then
      client.settings.python = vim.tbl_deep_extend("force", client.settings.python, { pythonPath = path })
    else
      client.config.settings = vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
    end
    client.notify("workspace/didChangeConfiguration", { settings = nil })
  end
end

vim.lsp.config["pyright"] = {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git",
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightOrganizeImports", function()
      client:exec_cmd({
        command = "pyright.organizeimports",
        arguments = { vim.uri_from_bufnr(bufnr) },
      })
    end, {
      desc = "Organize Imports",
    })
    vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightSetPythonPath", set_python_path, {
      desc = "Reconfigure pyright with the provided python path",
      nargs = 1,
      complete = "file",
    })
  end,
}
vim.lsp.enable("pyright")

-- bash-langugge-server config
vim.lsp.config["bashls"] = {
  cmd = { "bash-language-server", "start" },
  settings = {
    bashIde = {
      -- Glob pattern for finding and parsing shell script files in the workspace.
      -- Used by the background analysis features across files.

      -- Prevent recursive scanning which will cause issues when opening a file
      -- directly in the home directory (e.g. ~/foo.sh).
      --
      -- Default upstream pattern is "**/*@(.sh|.inc|.bash|.command)".
      globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
    },
  },
  filetypes = { "bash", "sh" },
  root_markers = { ".git" },
}
vim.lsp.enable("bashls")
