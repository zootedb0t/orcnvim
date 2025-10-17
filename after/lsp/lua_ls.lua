---@type vim.lsp.Config
return {
  cmd = { "lua-language-server" },
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
  filetypes = { "lua" },
  settings = {
    Lua = {
      workspace = {
        maxPreload = 5000,
        preloadFileSize = 10000,
        library = {
          vim.fn.expand("$VIMRUNTIME"),
        },
      },
      hint = { enable = true },
    },
  },
}
