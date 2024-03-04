local icons = require("core.icons")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

local plugin = {
  {
    "zootedb0t/citruszest.nvim",
    dev = true,
    lazy = false,
    priority = 1000,
    opts = {
      option = {
        transparent = true,
        bold = true,
      },
    },
  },
  -- {
  --   "maxmx03/fluoromachine.nvim",
  --   lazy = false,
  --   opts = {
  --     theme = "retrowave", -- Choose between retrowave, fluoromachine, delta
  --     brightness = 0.04,
  --     transparent = "full",
  --   },
  -- },

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
    event = "VeryLazy",
    config = function()
      require("plugins.treesitter")
    end,
    dependencies = {
      "hiphish/rainbow-delimiters.nvim",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    cmd = "TSContextToggle",
    config = function()
      require("plugins.others").treesitter_context()
    end,
  },

  {
    "neovim/nvim-lspconfig",
    ft = require("core.utils").lsp_filetype(),
    config = function()
      require("plugins.lsp.handlers").setup()
    end,
    dependencies = {
      "SmiteshP/nvim-navic",
      "mason-lspconfig.nvim",
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    config = function()
      require("plugins.lsp.mason")
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
    tag = "legacy",
    opts = {},
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      require("plugins.telescope")
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
      require("plugins.cmp")
    end,
    dependencies = {
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
  },

  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter" },
    branch = "v0.6",
    opts = {},
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
    keys = " ",
    config = function()
      require("plugins.whichkey")
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeFindFileToggle",
    config = function()
      require("plugins.nvim-tree")
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

  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "nvim-lua/plenary.nvim", lazy = true },
  { "dstein64/vim-startuptime", cmd = "StartupTime" },

  {
    "nvimdev/dashboard-nvim",
    cmd = "Dashboard",
    config = function()
      require("plugins.dashboard")
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
          if vim.bo.filetype == "dashboard" then
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

  {
    "nanozuki/tabby.nvim",
    event = "VeryLazy",
    config = function()
      require("tabby.tabline").use_preset("tab_only", {
        nerdfont = true, -- whether use nerdfont
      })
    end,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          -- default options: exact mode, multi window, all directions, with a backdrop
          require("flash").jump()
        end,
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
      },
    },
  },

  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.conform").config()
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    ft = require("core.utils").lint_filetype(),
    config = function()
      require("plugins.null-ls")
    end,
    dependencies = {
      "mason-lspconfig.nvim",
    },
  },

  {
    "toppair/peek.nvim",
    ft = "markdown",
    build = "deno task --quiet build:fast",
    config = function()
      require("plugins.others").peek()
    end,
  },
}

local opts = {
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
  performance = {
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
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
  install = {
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "citruszest" },
  },
  dev = {
    path = "~/Documents/repos/",
  },
  ui = {
    border = "single",
    icons = {
      cmd = icons.ui.BoxChecked,
      config = icons.ui.Gear,
      event = icons.ui.Pacman,
      ft = icons.kind.File,
      init = icons.ui.BoxChecked,
      import = icons.ui.SignIn,
      keys = icons.kind.Key,
      lazy = icons.ui.Timer,
      loaded = icons.ui.Check,
      not_loaded = icons.ui.Hourglass,
      runtime = icons.ui.Fire,
      source = icons.ui.Code,
      start = icons.ui.BoxChecked,
      task = icons.ui.Spanner,
    },
  },
}

require("lazy").setup(plugin, opts)
