local icon = require("core.icons")
return {
  "nvim-tree/nvim-tree.lua",
  cmd = "NvimTreeFindFileToggle",
  opts = {

    sync_root_with_cwd = true,
    view = {
      adaptive_size = true,
      width = 25,
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
      root_folder_label = false,
      icons = {
        git_placement = "after",
        glyphs = {
          default = icon.kind.File,
          symlink = icon.ui.FileSymlink,
          bookmark = icon.ui.BookMark,
          modified = icon.ui.Circle,
          folder = {
            default = icon.ui.Folder,
            open = icon.ui.FolderOpen,
            empty = icon.ui.EmptyFolder,
            empty_open = icon.ui.EmptyFolderOpen,
            symlink = icon.ui.FolderSymlink,
            symlink_open = icon.ui.FolderSymlink,
          },
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
  },
  -- config = function()
  --   require("plugins.nvim-tree")
  -- end,
}
