local M = {}
local plugin_stat = require("lazy").stats()
local alpha_ok, alpha = pcall(require, "alpha")
if alpha_ok then
  M.config = function()
    local headers = {
      nvim = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]],
      pacman = [[
             ██████
         ████▒▒▒▒▒▒████
       ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██
     ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██
   ██▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒
   ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▓▓▓▓
   ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓
 ██▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ██
 ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██
 ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██
 ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██
 ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██
 ██▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒██
 ████  ██▒▒██  ██▒▒▒▒██  ██▒▒██
 ██      ██      ████      ████
      ]],
      orcnvim = [[
 ██████╗ ██████╗  ██████╗███╗   ██╗██╗   ██╗██╗███╗   ███╗
██╔═══██╗██╔══██╗██╔════╝████╗  ██║██║   ██║██║████╗ ████║
██║   ██║██████╔╝██║     ██╔██╗ ██║██║   ██║██║██╔████╔██║
██║   ██║██╔══██╗██║     ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
╚██████╔╝██║  ██║╚██████╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
     ]],
    }
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = vim.split(headers.orcnvim, "\n")

    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
      dashboard.button("e", "󰈙  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
      dashboard.button("s", "  Load Session", ":Telescope persisted<CR>"),
      dashboard.button("c", "  Configuration", ":e $MYVIMRC<CR>"),
      dashboard.button("u", "  Update Plugins", ":Lazy sync<CR>"),
      dashboard.button("q", "  Quit Neovim", ":qa!<CR>"),
    }

    dashboard.section.footer.val = function()
      local total_plugins = plugin_stat.count
      local startuptime = (math.floor(plugin_stat.startuptime * 100 + 0.5) / 100)
      return " Orcnvim " .. total_plugins .. " plugins in " .. startuptime .. "ms"
    end

    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaShortcut"
    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
  end
end
return M
