local nvimtree_loaded = false

local function toggle_nvimtree()
  if not nvimtree_loaded then
    vim.pack.add({
      "https://github.com/DaikyXendo/nvim-material-icon",
      "https://github.com/nvim-tree/nvim-tree.lua",
    })

    require("nvim-tree").setup({
      sync_root_with_cwd = true,
      view = {
        adaptive_size = true,
        width = 25,
      },
      git = {
        ignore = false,
      },
      renderer = {
        indent_markers = {
          enable = true,
          inline_arrows = true,
        },
        root_folder_label = false,
      },
    })

    nvimtree_loaded = true
  end

  require("nvim-tree.api").tree.toggle()
end

vim.keymap.set("n", "\\", toggle_nvimtree, { desc = "Toggle file explorer" })
