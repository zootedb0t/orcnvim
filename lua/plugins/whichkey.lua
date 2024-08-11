local wk = require("which-key")

wk.setup({
  preset = "helix",
  icons = {
    rules = false,
  },
})

wk.add({
  { "<leader>;", "<cmd>Dashboard<CR>", desc = "Open Dashboard" },

  -- Open Dashboard
  {
    "<leader>/",
    function()
      require("telescope.builtin").current_buffer_fuzzy_find(
        require("telescope.themes").get_dropdown({ previewer = false })
      )
    end,
    desc = "Fuzzily search in current buffer",
  },

  -- Open Nvim-Tree
  { "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Open File Explorer" },

  -- Actions
  { "<leader>a", group = "Action" },
  { "<leader>ac", "<cmd>fclose<cr>", group = "Fold Close" },
  {
    "<leader>al",
    function()
      require("core.utils").toggle_number()
    end,
    group = "Fold Close",
  },
  { "<leader>an", "<cmd>tabnew<cr>", desc = "Open New Tab" },
  {
    "<leader>aq",
    function()
      require("core.utils").quickfix_toggle()
    end,
    desc = "Toggle Quickfix window",
  },
  {
    "<leader>as",
    function()
      require("core.utils").toggle_statusline()
    end,
    desc = "Toggle Statusline",
  },
  { "<leader>at", "<cmd>ToggleTerm<cr>", desc = "Open Terminal" },

  -- Buffers
  { "<leader>b", group = "Buffers" },
  { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "List buffers" },
  {
    "<leader>bc",
    function()
      require("nvim-highlight-colors").toggle()
    end,
    desc = "Toggle color highlight",
  },
  { "<leader>bd", "<cmd>bd<cr>", desc = "Delete buffer" },
  { "<leader>bh", "<cmd>bprevious<cr>", desc = "Previous Buffer" },
  { "<leader>bl", "<cmd>bnext<cr>", desc = "Next Buffer" },
  { "<leader>bn", "<cmd>enew<cr>", desc = "Create new buffer" },
  { "<leader>bs", "<cmd>wa!<CR>", desc = "Save" },
  { "<leader>bt", "<cmd>TSContextToggle<cr>", desc = "Treesitter Context" },

  -- Git
  { "<leader>g", group = "Git" },
  { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Show inline blame", group = "Git" },
  { "<leader>gc", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview current hunk" },
  { "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Current buffer diff" },
  { "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", desc = "Show next hunk" },
  { "<leader>gp", "<cmd>Gitsigns prev_hunk<cr>", desc = "Show previous hunk" },
  { "<leader>gq", "<cmd>Gitsigns setqflist<cr>", desc = "Show quickfix list" },

  -- Lsp
  { "<leader>l", group = "LSP" },
  { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
  { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", desc = "Current Buffer Diagnostics" },
  {
    "<leader>lf",
    function()
      require("plugins.conform").format()
    end,
    desc = "Format current buffer",
  },
  {
    "<leader>lh",
    function()
      require("core.utils").inlay_hint()
    end,
    desc = "Toggle Inlay Hint",
  },
  { "<leader>li", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
  { "<leader>lq", "<cmd>vim.diagnostic.setloclist<cr>", desc = "Quickfix Diagnostics" },
  { "<leader>lr", vim.lsp.buf.rename, desc = "Lsp Rename" },
  { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
  { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },

  -- Searches
  { "<leader>s", desc = "Search" },
  { "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
  { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Search Commands" },
  { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
  { "<leader>sg", "<Cmd>Telescope live_grep<CR>", desc = "Grep in CWD" },
  { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help Tags" },
  { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search highlight group" },
  { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Search keymaps" },
  { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Search Recent Files" },

  { "<leader>w", proxy = "<c-w>", group = "Windows" }, -- proxy to window mappings
})
