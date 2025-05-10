return {
  "mason-org/mason.nvim",
  build = ":MasonUpdate", -- :MasonUpdate updates registry contents
  event = "VeryLazy",
  init = function()
    -- Make mason packages available before loading it; allows to lazy-load mason.
    vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
  end,
  opts = {
    ui = {
      border = "single",
      width = 0.7,
      height = 0.7,
    },
  },
}
