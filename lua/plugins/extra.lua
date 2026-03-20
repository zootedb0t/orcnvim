return {
  { "DaikyXendo/nvim-material-icon", lazy = true },
  { "dstein64/vim-startuptime", cmd = "StartupTime" },
  {
    "nvim-treesitter/nvim-treesitter-context",
    cmd = "TSContextToggle",
    opts = {
      enable = false,
      zindex = 10,
    },
  },

  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter" },
    branch = "v0.6",
    opts = {},
  },
}
