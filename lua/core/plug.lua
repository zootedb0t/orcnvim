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
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = true,
    config = function()
      vim.g.moonflyTransparent = true
      vim.g.moonflyUnderlineMatchParen = true
    end,
  },
  {
    "maxmx03/fluoromachine.nvim",
    lazy = true,
    priority = 1000,
    opts = function()
      return {
        theme = "delta", -- Choose between retrowave, fluoromachine, delta
        brightness = 0.04,
        transparent = "full",
      }
    end,
  },
  {
    "numToStr/Comment.nvim",
    keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
    opts = function()
      return {
        ignore = "^$",
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("configs.treesitter")
    end,
    dependencies = {
      "HiPhish/nvim-ts-rainbow2",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("configs.lsp.handlers").setup()
    end,
    dependencies = {
      "cmp-nvim-lsp",
      "SmiteshP/nvim-navic",
      "mason-lspconfig.nvim",
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    config = function()
      require("configs.lsp.mason")
    end,
    dependencies = {
      "mason.nvim",
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("configs.null-ls")
    end,
    dependencies = {
      "mason.nvim",
    },
  },
  {
    "williamboman/mason.nvim",
    lazy = true,
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
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
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "LuaSnip",
    },
  },
  {
    "echasnovski/mini.pairs",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    version = false,
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "folke/which-key.nvim",
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
      vim.keymap.set("n", ",w", "<CMD>HopAnywhere<CR>")
    end,
    cmd = "HopAnywhere",
    opts = function()
      return {
        keys = "etovxqpdygfblzhckisuran",
      }
    end,
  },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    ft = "markdown",
    opts = {},
    config = function()
      local peek = require("peek")
      vim.api.nvim_create_user_command("PeekOpen", peek.open, {})
      vim.api.nvim_create_user_command("PeekClose", peek.close, {})
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    cmd = "ColorizerToggle",
    opts = function()
      return {
        user_default_options = {
          names = false,
        },
      }
    end,
  },

  { "kyazdani42/nvim-web-devicons", lazy = true },
  { "nvim-lua/plenary.nvim", lazy = true },
  { "dstein64/vim-startuptime", cmd = "StartupTime" },
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
    opts = function()
      return {
        autosave = false,
        should_autosave = function()
          -- do not autosave if the alpha dashboard is the current filetype
          if vim.bo.filetype == "alpha" then
            return false
          end
          return true
        end,
      }
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = {
      "ToggleTerm",
      "TermExec",
      "ToggleTermToggleAll",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualLines",
      "ToggleTermSendVisualSelection",
    },
    opts = function()
      return {
        size = 15,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        close_on_exit = true, -- close the terminal window when the process exits
        open_mapping = [[<c-\>]],
        border = "double",
        shell = "/usr/bin/fish",
      }
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
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
  -- concurrency = nil, ---@type number limit the maximum amount of concurrent tasks
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "fluoromachine" },
  },
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
  },
  -- lazy can generate helptags from the headings in markdown readme files,
  -- so :help works even for plugins that don't have vim docs.
  -- when the readme opens with :help it will be correctly displayed as markdown
  performance = {
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
        -- "loaded_netrw",
        -- "loaded_netrwPlugin",
      },
    },
  },
  checker = {
    enabled = true,
    frequency = 3600, -- check for updates every hour
    notify = false,
  },
}

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

lazy.setup(plugins, opts)
