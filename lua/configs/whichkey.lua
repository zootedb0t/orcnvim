local M = {}
local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  return
end

M.config = function()
  local setup = {
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = false, -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = false, -- misc bindings to work with windows
        z = false, -- bindings for folds, spelling and others prefixed with z
        g = false, -- bindings for prefixed with g
      },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      -- For example:
      -- ["<space>"] = "SPC",
      -- ["<cr>"] = "RET",
      -- ["<tab>"] = "TAB",
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
      border = "rounded", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 0, 2, 0 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "center", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", ":", "<Cmd>", "<cr>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "j", "k" },
      v = { "j", "k" },
    },
  }

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }
  local mappings = {
    ["e"] = { "<cmd>NvimTreeFindFileToggle<cr>", "Toggle file explore" },
    ["d"] = { "<cmd>ChangeDirectory<cr>", "Change working directory" },
    ["w"] = { "<cmd>w!<CR>", "Save" },
    -- ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
    b = {
      name = "Buffers",
      b = { "<cmd>Telescope buffers<cr>", "Buffers" },
      c = { "<cmd>ColorizerToggle<cr>", "Attach colorizer" },
      d = { "<cmd>bd<cr>", "Delete buffer" },
      n = { "<cmd>enew<cr>", "Create new buffer" },
      r = { "<cmd>SourceFile<cr>", "Source current buffer" },
    },
    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
      w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
      f = { vim.lsp.buf.format, "Format current buffer", silent = true },
      i = { "<cmd>LspInfo<cr>", "Info" },
      I = { "<cmd>Mason<cr>", "Mason Info" },
      j = {
        vim.diagnostic.goto_next,
        "Next Diagnostic",
      },
      k = {
        vim.diagnostic.goto_prev,
        "Prev Diagnostic",
      },
      l = { vim.lsp.codelens.run, "CodeLens Action" },
      q = { vim.diagnostic.setloclist, "Quickfix" },
      r = { vim.lsp.buf.rename, "Rename" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
      S = {
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        "Workspace Symbols",
      },
      e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
    },
    n = {
      name = "Neovim",
      c = {
        function()
          require("configs.telescope.custom").search_config()
        end,
        "Neovim configs",
      },
      s = { "<CMD>StartupTime<cr>", "StartupTime" },
      i = { "<CMD>Inspect<cr>", "Inspect" }, -- only available on neovim 0.9
      u = { "<CMD>Update<cr>", "Update" },
      h = { "<CMD>checkhealth<cr>", "Health" },
      v = { "<CMD>version<cr>", "Version" },
    },
    p = {
      name = "Plugin",
      c = { "<CMD>Lazy clean<cr>", "Clean" },
      C = { "<CMD>Lazy check<cr>", "Check" },
      d = { "<CMD>Lazy debug<cr>", "Debug" },
      i = { "<CMD>Lazy install<cr>", "Install" },
      s = { "<CMD>Lazy sync<cr>", "Sync" },
      l = { "<CMD>Lazy log<cr>", "Log" },
      h = { "<CMD>Lazy home<cr>", "Home" },
      H = { "<CMD>Lazy help<cr>", "Help" },
      p = { "<CMD>Lazy profile<cr>", "Profile" },
      u = { "<CMD>Lazy update<cr>", "Update" },
    },
    s = {
      name = "Search",
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      f = { "<cmd>Telescope find_files<cr>", "Find File" },
      g = { "<Cmd>Telescope live_grep<CR>", "Grep in cwd" },
      h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
      H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
      M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
      r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
      R = { "<cmd>Telescope registers<cr>", "Registers" },
      t = { "<cmd>Telescope live_grep<cr>", "Text" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      C = { "<cmd>Telescope commands<cr>", "Commands" },
    },
    m = {
      name = "Session Manager",
      s = { "<cmd>SessionSave<CR>", "Save Session" },
      l = { "<cmd>SessionLoad<CR>", "Load Saved Sessions" },
    },
  }
  wk.setup(setup)
  wk.register(mappings, opts)
end

return M
