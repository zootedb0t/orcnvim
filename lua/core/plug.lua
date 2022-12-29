local M = {}
function M.config()
  local status_ok, lazy = pcall(require, "lazy")
  if status_ok then
    lazy.setup({
      {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        enabled = true,
        -- config = function()
        --   vim.cmd("colorscheme rose-pine")
        -- end,
      },
      {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
          require("catppuccin").setup({
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            background = { -- :h background
              light = "latte",
              dark = "mocha",
            },
            transparent_background = true,
            term_colors = true,
          })
          vim.cmd("colorscheme catppuccin")
        end,
      },
      {
        "numToStr/Comment.nvim",
        -- keys = { "gc", "gb" },
        event = { "BufRead" },
        config = function()
          require("Comment").setup({
            ignore = "^$",
          })
        end,
      },
      {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufRead", "BufNewFile" },
        opt = true,
        config = function()
          require("configs.treesitter")
        end,
        dependencies = {
          "p00f/nvim-ts-rainbow",
        },
      },
      {
        "windwp/nvim-ts-autotag",
        ft = { "html" },
      },
      {
        "neovim/nvim-lspconfig",
        dependencies = {
          { "hrsh7th/cmp-nvim-lsp" },
          {
            "j-hui/fidget.nvim",
            config = function()
              require("fidget").setup()
            end,
          },
        },
      },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require("configs.null-ls").config()
        end,
      },
      {
        "nvim-telescope/telescope.nvim",
        -- event = "VimEnter",
        -- cmd = "Telescope",
        config = function()
          require("configs.telescope")
        end,
        dependencies = {
          { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
          { "nvim-telescope/telescope-file-browser.nvim" },
        },
      },
      {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = function()
          require("configs.cmp").config()
        end,
        dependencies = {
          { "hrsh7th/cmp-path" },
          { "hrsh7th/cmp-buffer" },
          { "hrsh7th/cmp-nvim-lsp" },
          { "saadparwaiz1/cmp_luasnip" },
          { "rafamadriz/friendly-snippets" },
          { "hrsh7th/cmp-nvim-lsp-signature-help" },
          {
            "windwp/nvim-autopairs",
            config = function()
              require("configs.others").pair()
            end,
          },
          {
            "L3MON4D3/LuaSnip",

            config = function()
              require("configs.luasnip").config()
            end,
          },
        },
      },
      {
        "lewis6991/gitsigns.nvim",
        config = function()
          require("gitsigns").setup()
        end,
      },
      {
        "folke/which-key.nvim",
        config = function()
          require("configs.whichkey").config()
        end,
      },
      {

        "nvim-tree/nvim-tree.lua",
        tag = "nightly", -- optional, updated every week. (see issue #1193)
        cmd = "NvimTreeFindFileToggle",
        config = function()
          require("configs.nvim-tree").config()
        end,
      },
      {

        "phaazon/hop.nvim",
        branch = "v2", -- optional but strongly recommended
        init = function()
          vim.keymap.set("n", ",w", "<CMD>HopWord<CR>")
        end,
        cmd = "HopWord",
        config = function()
          require("configs.others").hop()
        end,
      },
      {
        "toppair/peek.nvim",
        run = "deno task --quiet build:fast",
        ft = "markdown",
        config = function()
          require("configs.others").peek()
        end,
      },
      {
        "rcarriga/nvim-notify",
        config = function()
          require("notify").setup()
        end,
      },
      {
        "NvChad/nvim-colorizer.lua",
        cmd = "ColorizerToggle",
        config = function()
          require("colorizer").setup({
            user_default_options = {
              names = false,
            },
          })
        end,
      },

      {
        "kyazdani42/nvim-web-devicons",
      },
      {
        "nvim-lua/popup.nvim",
      },
      {
        "nvim-lua/plenary.nvim",
      },
      {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
      },
    })
  end
end

return M
