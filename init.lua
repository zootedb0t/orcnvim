--[[

███╗   ██╗██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
████╗  ██║██║   ██║██║████╗ ████║██╔══██╗██╔════╝
██╔██╗ ██║██║   ██║██║██╔████╔██║██████╔╝██║
██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝

https://github.com/zootedb0t/orcnvim   ¯\_(ツ)_/¯
--]]

require("core.options")
require("core.keymappings")
require("core.plug")
require("core.utils.command") -- Custom commands
require("core.autocmd")

require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "macchiato",
  },
  transparent_background = true,
  term_colors = true,
})
vim.cmd("colorscheme catppuccin")
