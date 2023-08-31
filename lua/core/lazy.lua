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

local plugins = {
  {
    "zootedb0t/citruszest.nvim",
    dev = true,
    lazy = false,
    priority = 1000,
    opts = {
      option = {
        transparent = true,
      },
      style = {
        Identifier = { bold = true },
      },
    },
  },

  -- {
  --   "maxmx03/fluoromachine.nvim",
  --   lazy = false,
  --   opts = {
  --     theme = "fluoromachine", -- Choose between retrowave, fluoromachine, delta
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
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("configs.treesitter")
    end,
    dependencies = {
      "hiphish/rainbow-delimiters.nvim",
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
    cmd = "NvimTreeFindFileToggle",
    config = function()
      require("configs.nvim-tree")
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

  { "nvim-tree/nvim-web-devicons", lazy = true },
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
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require("configs.lint")
    end,
  },

  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    config = function()
      require("configs.format")
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
  },
}

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

lazy.setup(plugins, opts)
