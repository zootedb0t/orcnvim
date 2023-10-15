local icons = require("core.icons")
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

local logo = string.rep("\n", 3) .. headers.orcnvim .. "\n\n"

local db_config = {
  theme = "doom",
  config = {
    header = vim.split(logo, "\n"),
    center = {
      {
        icon = icons.ui.Files,
        desc = " Search Buffer",
        key = "b",
        action = "Telescope buffers",
      },
      {
        icon = icons.ui.Telescope,
        desc = " Find File",
        key = "f",
        action = "Telescope find_files",
      },
      {
        icon = icons.ui.History,
        desc = " Recent Files",
        key = "r",
        action = "Telescope oldfiles",
      },
      {
        icon = icons.ui.NewFile,
        desc = " New File",
        key = "n",
        action = "ene | startinsert",
      },
      {
        icon = icons.ui.Hourglass,
        desc = " Load Session",
        key = "s",
        action = "Telescope persisted",
      },
      {
        icon = icons.ui.Package,
        desc = " Lazy Plugin",
        key = "l",
        action = "Lazy",
      },
      {
        icon = icons.ui.Exit,
        desc = " Quit",
        key = "q",
        action = "qa",
      },
    },
    footer = {},
  },
}

for _, button in ipairs(db_config.config.center) do
  button.desc = button.desc .. string.rep(" ", 30 - #button.desc)
end

require("dashboard").setup(db_config)
