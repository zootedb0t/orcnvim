local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

local plugins = {
  {
    "catppuccin/nvim",
    name = "catppuccin",
  },
  -- { "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },
  { "shatur/neovim-ayu", lazy = false, priority = 1000 },
  {
    "numToStr/Comment.nvim",
    keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
    -- event = { "BufReadPost", "BufNewFile", "BufNew" },
    config = function()
      require("Comment").setup({
        ignore = "^$",
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufRead", "BufNewFile", "BufNew" },
    config = function()
      require("configs.treesitter")
    end,
    dependencies = {
      "mrjones2014/nvim-ts-rainbow",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html" },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufNewFile", "BufNew" },
    config = function()
      require("configs.lsp.mason")
      require("configs.lsp.handlers").setup()
      require("configs.null-ls")
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      {
        "williamboman/mason.nvim",
      },
      "williamboman/mason-lspconfig.nvim",
      {
        "jose-elias-alvarez/null-ls.nvim",
      },
      { "SmiteshP/nvim-navic" },
    },
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
    event = "LspAttach",
  },
  {
    "nvim-telescope/telescope.nvim",
    -- event = "VimEnter",
    cmd = "Telescope",
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
      require("configs.cmp")
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
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
    event = { "BufRead", "BufNewFile", "BufNew" },
  },
  {
    "folke/which-key.nvim",
    cmd = "WhichKey",
    keys = "<leader>",
    config = function()
      require("configs.whichkey").config()
    end,
  },
  {

    "nvim-tree/nvim-tree.lua",
    tag = "nightly", -- optional, updated every week. (see issue #1193)
    cmd = "NvimTreeFindFileToggle",
    config = function()
      require("configs.nvim-tree")
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
    build = "deno task --quiet build:fast",
    ft = "markdown",
    config = function()
      require("configs.others").peek()
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
  {
    "goolord/alpha-nvim",
    cmd = "Alpha",
    config = function()
      require("configs.alpha").config()
    end,
  },
  {
    "olimorris/persisted.nvim",
    cmd = {
      "SessionToggle",
      "SessionStart",
      "SessionSave",
      "SessionLoad",
    },
    config = function()
      require("persisted").setup({
        autosave = false,
        should_autosave = function()
          -- do not autosave if the alpha dashboard is the current filetype
          if vim.bo.filetype == "alpha" then
            return false
          end
          return true
        end,
      })
    end,
  },
}

local opts = {
  git = {
    -- defaults for the `Lazy log` command
    -- log = { "-10" }, -- show the last 10 commits
    log = { "--since=3 days ago" }, -- show commits from the last 3 days
    timeout = 300, -- kill processes that take more than 2 minutes
    url_format = "https://github.com/%s.git",
  },
  lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json", -- lockfile generated after running update.
  -- concurrency = nil, ---@type number limit the maximum amount of concurrent tasks
  -- install = {
  --   -- install missing plugins on startup. This doesn't increase startup time.
  --   missing = true,
  --   -- try to load one of these colorschemes when starting an installation during startup
  --   colorscheme = { "catppuccin" },
  -- },
  ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 0.8, height = 0.8 },
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    -- border = "rounded",
    icons = {
      cmd = " ",
      config = "",
      event = "",
      ft = " ",
      init = " ",
      keys = " ",
      plugin = " ",
      runtime = " ",
      source = " ",
      start = "",
      task = "✔ ",
    },
    throttle = 20, -- how frequently should the ui process render events
    custom_keys = {},
    diff = {
      -- diff command <d> can be one of:
      -- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
      --   so you can have a different command for diff <d>
      -- * git: will run git diff and open a buffer with filetype git
      -- * terminal_git: will open a pseudo terminal with git diff
      -- * diffview.nvim: will open Diffview to show the diff
      cmd = "git",
    },
  },
  -- lazy can generate helptags from the headings in markdown readme files,
  -- so :help works even for plugins that don't have vim docs.
  -- when the readme opens with :help it will be correctly displayed as markdown
  performance = {
    cache = {
      enabled = true,
      path = vim.fn.stdpath("state") .. "/lazy/cache",
      -- Once one of the following events triggers, caching will be disabled.
      -- To cache all modules, set this to `{}`, but that is not recommended.
      -- The default is to disable on:
      --  * VimEnter: not useful to cache anything else beyond startup
      --  * BufReadPre: this will be triggered early when opening a file from the command line directly
      disable_events = { "VimEnter", "BufReadPre" },
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = false, -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        "gzip", -- disable gzip
        "matchit",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "loaded_2html_plugin", -- disable 2html
        "loaded_getscript", -- disable getscript
        "loaded_getscriptPlugin", -- disable getscript
        "loaded_vimball", -- disable vimball
        "loaded_vimballPlugin", -- disable vimball
        "loaded_netrw",
        "loaded_netrwPlugin",
      },
    },
    checker = {
      enabled = true,
      frequency = 15, -- check for updates every hour
    },
  },
}

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

lazy.setup(plugins, opts)
