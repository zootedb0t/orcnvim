--[[

███╗   ██╗██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
████╗  ██║██║   ██║██║████╗ ████║██╔══██╗██╔════╝
██╔██╗ ██║██║   ██║██║██╔████╔██║██████╔╝██║
██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝

https://github.com/zootedb0t/orcnvim   ¯\_(ツ)_/¯
--]]

if vim.loader then
  vim.loader.enable()
end -- enable vim.loader early if available #22668

require("core.options") -- Neovim options
require("core.keymappings") -- My keybinding
require("core.plug") -- Lazy plugin manager
require("core.utils.command") -- Custom commands
require("core.autocmd") -- Autocommand
require("core.ui.colorscheme") -- Colorscheme related settings
