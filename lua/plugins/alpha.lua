local M = {}
local plugin_stat = require("lazy").stats()
local icons = require("core.icons")
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
      dashboard.button("f", icons.ui.Telescope .. "  Find File", ":Telescope find_files<CR>"),
      dashboard.button("e", icons.ui.File .. "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", icons.ui.History .. "  Recent Files", ":Telescope oldfiles<CR>"),
      dashboard.button("s", icons.ui.Hourglass .. "  Load Session", ":Telescope persisted<CR>"),
      dashboard.button("c", icons.ui.Spanner .. "  Configuration", ":e $MYVIMRC<CR>"),
      dashboard.button("u", icons.ui.Package .. "  Update Plugins", ":Lazy sync<CR>"),
      dashboard.button("q", icons.diagnostics.BoldError .. "  Quit Neovim", ":qa!<CR>"),
    }

    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end

    dashboard.section.footer.val = function()
      local total_plugins = plugin_stat.count
      local startuptime = (math.floor(plugin_stat.startuptime * 100 + 0.5) / 100)
      return "Loaded " .. total_plugins .. " plugins in 󰔛 " .. startuptime .. "ms"
    end

    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.section.header.opts.hl = "AlphaHeader"
    alpha.setup(dashboard.opts)
  end
end
return M
