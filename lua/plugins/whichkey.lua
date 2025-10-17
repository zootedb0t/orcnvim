return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    icons = {
      rules = false,
    },
    spec = {
      -- Open Dashboard
      { "<leader>;", "<cmd>Dashboard<CR>", desc = "Open Dashboard" },

      -- Fuzzy search current buffer
      {
        "<leader>/",
        "<cmd>FzfLua grep_curbuf<cr>",
        desc = "Fuzzy search current buffer",
      },

      {
        -- Actions
        { "<leader>a", group = "Action" },
        { "<leader>ac", "<cmd>fclose<cr>", group = "Fold Close" },
        {
          "<leader>al",
          function()
            require("orcnvim.utils").toggle_number()
          end,
          group = "Fold Close",
        },
        { "<leader>an", "<cmd>tabnew<cr>", desc = "Open New Tab" },
        {
          "<leader>aq",
          function()
            require("orcnvim.utils").quickfix_toggle()
          end,
          desc = "Toggle Quickfix window",
        },
        {
          "<leader>as",
          function()
            require("orcnvim.utils").toggle_statusline()
          end,
          desc = "Toggle Statusline",
        },
        { "<leader>at", "<cmd>ToggleTerm<cr>", desc = "Open Terminal" },
      },

      {
        -- Buffers
        { "<leader>b", group = "Buffers" },
        { "<leader>bb", "<cmd>FzfLua buffers<cr>", desc = "List buffers" },
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
      },

      {
        -- Git
        { "<leader>g", group = "Git" },
        { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Show inline blame", group = "Git" },
        { "<leader>gc", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview current hunk" },
        { "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Current buffer diff" },
        { "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", desc = "Show next hunk" },
        { "<leader>gp", "<cmd>Gitsigns prev_hunk<cr>", desc = "Show previous hunk" },
        { "<leader>gq", "<cmd>Gitsigns setqflist<cr>", desc = "Show quickfix list" },
      },

      {
        -- Lsp
        { "<leader>l", group = "LSP" },
        { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action" },
        { "<leader>ld", "<cmd>FzfLua lsp_document_diagnostics<cr>", desc = "Current Buffer Diagnostics" },
        {
          "<leader>lf",
          function()
            local conform = require("conform")
            conform.format({ lsp_format = "fallback" })
          end,
          desc = "Format current buffer",
        },
        {
          "<leader>lh",
          function()
            require("orcnvim.utils").inlay_hint()
          end,
          desc = "Toggle Inlay Hint",
        },
        { "<leader>li", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
        { "<leader>lq", vim.diagnostic.setloclist, desc = "Quickfix Diagnostics" },
        { "<leader>lr", vim.lsp.buf.rename, desc = "Lsp Rename" },
        { "<leader>lS", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
      },

      {
        -- Searches
        { "<leader>s", desc = "Search" },
        { "<leader>sb", "<cmd>FzfLua git_branches<cr>", desc = "Checkout branch" },
        { "<leader>sc", "<cmd>FzfLua commands<cr>", desc = "Search Commands" },
        { "<leader>sf", "<cmd>FzfLua files<cr>", desc = "Find Files" },
        { "<leader>sg", "<Cmd>FzfLua live_grep<CR>", desc = "Grep in CWD" },
        { "<leader>sh", "<cmd>FzfLua helptags<cr>", desc = "Find Help Tags" },
        { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Search keymaps" },
        { "<leader>sr", "<cmd>FzfLua oldfiles<cr>", desc = "Search Recent Files" },
      },

      { "<leader>w", proxy = "<c-w>", group = "Windows" }, -- proxy to window mappings
    },
  },
}
