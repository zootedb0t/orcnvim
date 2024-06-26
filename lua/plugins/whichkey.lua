local wk = require("which-key")
local icon = require("core.icons")

local setup = {
  plugins = {
    presets = {
      text_objects = false,
    },
  },
  icons = {
    breadcrumb = "»",
    separator = "",
  },
  popup_mappings = {
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    winblend = 0,
  },
  layout = {
    spacing = 3,
    align = "center",
  },
  ignore_missing = true,
  show_help = true,
  triggers = "auto",
  disable = {
    buftypes = {},
    filetypes = { "help", "NivmTree" },
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
  ["d"] = {
    function()
      require("core.utils").change_root_directory()
    end,
    "Change working directory",
  },
  [";"] = { "<cmd>Dashboard<CR>", "Open Dashboard" },
  ["/"] = {
    function()
      require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        previewer = false,
      }))
    end,
    "Fuzzily search in current buffer",
  },
  a = {
    name = icon.ui.Rocket .. " Actions",
    c = { "<cmd>fclose<cr>", "Close floating window" }, -- Only in nightly
    l = {
      function()
        require("core.utils").toggle_number()
      end,
      "Toggle Line Numbers",
    },
    q = {
      function()
        require("core.utils").quickfix_toggle()
      end,
      "Toggle Quickfix window",
    },
    s = {
      function()
        require("core.utils").toggle_statusline()
      end,
      "Toggle Statusline",
    },
    n = { "<cmd>tabnew<cr>", "Open New Tab" },
    t = { "<cmd>ToggleTerm<cr>", "Open Terminal" },
  },
  b = {
    name = icon.ui.File .. " Buffers",
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    c = {
      function()
        require("nvim-highlight-colors").toggle()
      end,
      "Toggle color highlight",
    },
    d = { "<cmd>bd<cr>", "Delete buffer" },
    l = { "<cmd>bnext<cr>", "Next Buffer" },
    h = { "<cmd>bprevious<cr>", "Next Buffer" },
    n = { "<cmd>enew<cr>", "Create new buffer" },
    s = { "<cmd>wa!<CR>", "Save" },
    t = { "<cmd>TSContextToggle<cr>", "Treesitter Context" },
  },
  g = {
    name = icon.git.Octoface .. " Git Actions",
    b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Show inline blame" },
    c = { "<cmd>Gitsigns preview_hunk<cr>", "Preview current hunk" },
    d = { "<cmd>Gitsigns diffthis<cr>", "Current buffer diff" },
    n = { "<cmd>Gitsigns next_hunk<cr>", "Show next hunk" },
    p = { "<cmd>Gitsigns prev_hunk<cr>", "Show previous hunk" },
    q = { "<cmd>Gitsigns setqflist<cr>", "Show quickfix list" },
  },
  l = {
    name = icon.ui.Code .. " LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Current Buffer Diagnostics" },
    h = {
      function()
        require("core.utils").inlay_hint()
      end,
      "Toggle Inlay Hint",
    },
    w = { "<cmd>Telescope diagnostics<cr>", "Show Workspace Diagnostics" },
    f = {
      function()
        require("plugins.conform").format()
      end,
      "Format current buffer",
    },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>Mason<cr>", "Mason Info" },
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
    name = icon.ui.Neovim .. " Neovim",
    c = {
      function()
        require("plugins.telescope.custom").search_config()
      end,
      "Neovim configs",
    },
    s = { "<cmd>StartupTime<cr>", "StartupTime" },
    i = { "<cmd>Inspect<cr>", "Inspect" },
    h = { "<cmd>checkhealth<cr>", "Health" },
    v = { "<cmd>version<cr>", "Version" },
  },
  m = {
    name = icon.ui.Timer .. " Session Manager",
    s = { "<cmd>SessionSave<CR>", "Save Session" },
    l = { "<cmd>Telescope persisted<CR>", "Load Saved Sessions" },
  },
  p = {
    name = icon.ui.Spanner .. " Plugin Manager",
    c = { "<cmd>Lazy clean<cr>", "Clean" },
    C = { "<cmd>Lazy check<cr>", "Check" },
    d = { "<cmd>Lazy debug<cr>", "Debug" },
    i = { "<cmd>Lazy install<cr>", "Install" },
    s = { "<cmd>Lazy sync<cr>", "Sync" },
    l = { "<cmd>Lazy log<cr>", "Log" },
    h = { "<cmd>Lazy home<cr>", "Home" },
    H = { "<cmd>Lazy help<cr>", "Help" },
    p = { "<cmd>Lazy profile<cr>", "Profile" },
    u = { "<cmd>Lazy update<cr>", "Update" },
  },
  s = {
    name = icon.ui.Search .. " Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    g = { "<Cmd>Telescope live_grep<CR>", "Grep in cwd" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Search registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Search Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Search Commands" },
  },
}
wk.setup(setup)
wk.register(mappings, opts)
