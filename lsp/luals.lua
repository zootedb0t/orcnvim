return {
  cmd = { "lua-language-server" },
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = (function()
          local runtime_path = vim.split(package.path, ";")
          table.insert(runtime_path, "lua/?.lua")
          table.insert(runtime_path, "lua/?/init.lua")
          return runtime_path
        end)(),
      },
      diagnostics = {
        globals = {
          "vim",
        },
      },
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
