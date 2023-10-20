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
        icon = icons.ui.NewFile .. " ",
        desc = "New File",
        key = "n",
        action = "ene | startinsert",
      },
      {
        icon = icons.ui.Telescope .. " ",
        desc = "Find File",
        key = "f",
        action = "Telescope find_files",
      },
      {
        icon = icons.ui.Files .. " ",
        desc = "Search Buffer",
        key = "b",
        action = "Telescope buffers",
      },
      {
        icon = icons.ui.Gear .. " ",
        desc = "Edit Config",
        key = "c",
        action = function()
          require("plugins.telescope.custom").search_config()
        end,
      },
      {
        icon = icons.ui.History .. " ",
        desc = "Recent Files",
        key = "r",
        action = "Telescope oldfiles",
      },
      {
        icon = icons.ui.Hourglass .. " ",
        desc = "Load Session",
        key = "s",
        action = "Telescope persisted",
      },
      {
        icon = icons.ui.Package .. " ",
        desc = "Lazy Plugin",
        key = "l",
        action = "Lazy",
      },
      {
        icon = icons.ui.Exit .. " ",
        desc = "Quit",
        key = "q",
        action = "qa",
      },
    },
    footer = function()
      local footer = {}
      footer[1] = os.date("󰃭 %a,%d %b \t 󱑎 %H:%M")
      footer[2] = icons.ui.Neovim
        .. " "
        .. vim.version().major
        .. "."
        .. vim.version().minor
        .. "-"
        .. vim.version().prerelease
      return footer
    end,
  },
}

for _, button in ipairs(db_config.config.center) do
  button.desc = button.desc .. string.rep(" ", 30 - #button.desc)
  button.key_format = "%s"
end

require("dashboard").setup(db_config)
