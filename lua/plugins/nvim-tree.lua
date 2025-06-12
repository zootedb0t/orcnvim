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
      },
      root_folder_label = false,
    },
  },
}
