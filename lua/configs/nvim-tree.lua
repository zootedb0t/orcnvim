local status_ok, tree = pcall(require, "nvim-tree")
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
  })
end
