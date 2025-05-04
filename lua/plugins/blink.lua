return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  build = "cargo build --release",
  event = "InsertEnter",
  opts = {
    -- keymap = { preset = "default" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    completion = {
      accept = {
        -- experimental auto-brackets support
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        border = "rounded",
        draw = {
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
        window = { border = "rounded" },
      },
    },
    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release
      use_nvim_cmp_as_default = false,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      nerd_font_variant = "normal",
      kind_icons = require("orcnvim.icons").kind,
    },
    keymap = {
      preset = "enter",
      ["<C-y>"] = { "select_and_accept" },
    },
    signature = { enabled = true },
  },
}
