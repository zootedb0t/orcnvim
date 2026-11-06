-- local blink_loaded = false

-- local function load_blink()
--   if blink_loaded then
--     return
--   end
--   blink_loaded = true

vim.pack.add({
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/saghen/blink.lib",
  "https://github.com/saghen/blink.cmp",
})

local blink = require("blink.cmp")
blink.build():wait(60000)

blink.setup({
  keymap = { preset = "super-tab" },
  completion = {
    menu = { auto_show = true },
    documentation = { auto_show = true },
  },
  signature = { enabled = true },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
})
-- end

-- vim.api.nvim_create_autocmd("InsertEnter", {
--   once = true,
--   callback = load_blink,
-- })
