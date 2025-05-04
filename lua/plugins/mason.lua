return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    opts = {
      ui = {
        border = "single",
        width = 0.7,
        height = 0.7,
      },
    },
  },
}
