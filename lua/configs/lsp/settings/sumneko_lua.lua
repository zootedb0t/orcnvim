return {
  settings = {
    Lua = {
      completion = {
        enable = true,
        callSnippet = "Replace",
        showWord = "Disable",
      },
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
        enable = true,
        globals = {
          "vim",
        },
      },
      workspace = {
        preloadFileSize = 400,
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
}
