local M = {}

function M.config()
  local present, snippy = pcall(require, "luasnip")
  if present then
    snippy.setup({
      require("luasnip.loaders.from_vscode").lazy_load(),
    })
  end
end

return M
