local M = {}
local alpha_ok, alpha = pcall(require, "alpha")
if alpha_ok then
  M.config = function()
    local headers = {
      ["nvim"] = {
        " ",
        " ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      },
      ["pacman"] = {
        "                                    ██████                                    ",
        "                                ████▒▒▒▒▒▒████                                ",
        "                              ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                              ",
        "                            ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                            ",
        "                          ██▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒                              ",
        "                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▓▓▓▓                          ",
        "                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓                          ",
        "                        ██▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ██                        ",
        "                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ",
        "                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ",
        "                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ",
        "                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ",
        "                        ██▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒██                        ",
        "                        ████  ██▒▒██  ██▒▒▒▒██  ██▒▒██                        ",
        "                        ██      ██      ████      ████                        ",
      },
    }
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = headers.pacman

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
      local version = " " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
      local lazy_ok, lazy = pcall(require, "lazy")
      if lazy_ok then
        local total_plugins = "   " .. lazy.stats().count .. " Plugins"
        return version .. total_plugins
      else
        return version
      end
    end

    dashboard.section.footer.opts.hl = "DashboardFooter"
    dashboard.section.header.opts.hl = "DashboardHeader"
    dashboard.section.buttons.opts.hl = "DashboarShortcut"
    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
  end
end
return M
