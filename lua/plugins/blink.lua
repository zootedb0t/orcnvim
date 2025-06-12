return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  build = "cargo build --release",
  event = "LspAttach",
  opts = {
    sources = {
      default = { "lsp", "snippets", "path", "buffer" },
    },
    completion = {
      list = {
        selection = { preselect = false, auto_insert = true },
      },
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        border = "rounded",
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "kind", gap = 1 },
          },
        },
      },
      documentation = {
        auto_show = true,
        window = { border = "rounded" },
      },
    },
    appearance = {
      -- use_nvim_cmp_as_default = false,
      kind_icons = require("orcnvim.icons").kind,
    },
    keymap = {
      preset = "enter",
      ["<C-y>"] = { "select_and_accept" },
    },
    signature = { enabled = true },
    fuzzy = {
      implementation = "rust",
      sorts = {
        "exact",
        "score",
        "sort_text",
      },
    },
    cmdline = {
      enabled = false,
    },
  },
}
