local function load_dashboard()
  vim.pack.add({ "https://github.com/nvimdev/dashboard-nvim" })

  local icons = require("orcnvim.icons")
  local headers = {
    orcnvim = [[
 ██████╗ ██████╗  ██████╗███╗   ██╗██╗   ██╗██╗███╗   ███╗
██╔═══██╗██╔══██╗██╔════╝████╗  ██║██║   ██║██║████╗ ████║
██║   ██║██████╔╝██║     ██╔██╗ ██║██║   ██║██║██╔████╔██║
██║   ██║██╔══██╗██║     ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
╚██████╔╝██║  ██║╚██████╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
     ]],
    orcnvim_new = [[
 ▄▄▄▄▄▄▄ ▄▄▄▄▄▄   ▄▄▄▄▄▄▄ ▄▄    ▄ ▄▄   ▄▄ ▄▄▄ ▄▄   ▄▄
█       █   ▄  █ █       █  █  █ █  █ █  █   █  █▄█  █
█   ▄   █  █ █ █ █       █   █▄█ █  █▄█  █   █       █
█  █ █  █   █▄▄█▄█     ▄▄█       █       █   █       █
█  █▄█  █    ▄▄  █    █  █  ▄    █       █   █       █
█       █   █  █ █    █▄▄█ █ █   ██     ██   █ ██▄██ █
█▄▄▄▄▄▄▄█▄▄▄█  █▄█▄▄▄▄▄▄▄█▄█  █▄▄█ █▄▄▄█ █▄▄▄█▄█   █▄█
  ]],
  }

  local logo = string.rep("\n\n", 1) .. headers.orcnvim_new .. "\n"

  require("dashboard").setup({
    theme = "doom",
    config = {
      header = vim.split(logo, "\n"),
      center = {
        {
          icon = icons.ui.NewFile .. " ",
          desc = "New File",
          key = "n",
          action = "ene | startinsert",
        },
        {
          icon = icons.ui.Telescope .. " ",
          desc = "Find File",
          key = "f",
          action = "FzfLua find_files",
        },
        {
          icon = icons.ui.Files .. " ",
          desc = "Search Buffer",
          key = "b",
          action = "FzfLua buffers",
        },
        {
          icon = icons.ui.Gear .. " ",
          desc = "Edit Config",
          key = "c",
          action = "FzfLua files cwd=~/.config/nvim/",
        },
        {
          icon = icons.ui.History .. " ",
          desc = "Recent Files",
          key = "r",
          action = "FzfLua oldfiles",
        },
        {
          icon = icons.ui.Hourglass .. " ",
          desc = "Load Session",
          key = "s",
          action = "FzfLua persisted",
        },
        {
          icon = icons.ui.Exit .. " ",
          desc = "Quit",
          key = "q",
          action = "qa",
        },
      },
      footer = function()
        return {
          os.date("󱑎 %H:%M \t 󰃭 %a,%d %b "),
          icons.ui.Neovim
            .. " "
            .. vim.version().major
            .. "."
            .. vim.version().minor
            .. "-"
            .. vim.version().prerelease,
        }
      end,
    },
  })

  vim.cmd.Dashboard() -- actually open it now that setup() has registered dashboard-nvim's own command
end

vim.api.nvim_create_user_command("Dashboard", load_dashboard, { desc = "Open the dashboard" })
