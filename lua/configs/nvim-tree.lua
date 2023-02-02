local status_ok, tree = pcall(require, "nvim-tree")
local icon = require("core.icons")
if status_ok then
  tree.setup({
    sync_root_with_cwd = true,
    -- open_on_setup = true,
    ignore_ft_on_setup = {
      "alpha",
    },
    view = {
      adaptive_size = false,
    },
    git = {
      ignore = false, -- Show files that are not managed by git
    },
    renderer = {
      indent_markers = {
        enable = true,
        inline_arrows = true,
        icons = {
          corner = "└",
          edge = "│",
          item = "│",
          bottom = "─",
          none = " ",
        },
      },
      icons = {
        glyphs = {
          default = icon.kind.File,
          symlink = icon.ui.FileSymlink,
          bookmark = icon.ui.BookMark,
          modified = icon.ui.Circle,
          git = {
            unstaged = icon.git.FileUnstaged,
            staged = icon.git.FileStaged,
            unmerged = icon.git.FileUnmerged,
            renamed = icon.git.FileRenamed,
            untracked = icon.git.FileUntracked,
          },
        },
      },
    },
  })
end
