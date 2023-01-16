local M = {}

function M.config()
  local status_ok, tree = pcall(require, "nvim-tree")
  if status_ok then
    tree.setup({
      sync_root_with_cwd = true,
      view = {
        adaptive_size = false,
      },
      git = {
        ignore = false, -- Show files that are not managed by git
      },
    })
  end
end

return M
