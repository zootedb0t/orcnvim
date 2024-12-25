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

require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },

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
})
