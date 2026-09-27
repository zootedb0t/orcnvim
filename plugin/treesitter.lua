vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

local ts_loaded = false

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    if not ts_loaded then
      vim.pack.add({
        {
          src = "https://github.com/nvim-treesitter/nvim-treesitter",
          version = "main",
        },
        -- { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
        { src = "https://github.com/windwp/nvim-ts-autotag" },
      })

      require("nvim-treesitter").install({
        "bash",
        "c",
        "comment",
        "cmake",
        "cpp",
        "css",
        "go",
        "html",
        "javascript",
        "java",
        "jsdoc",
        "json",
        "lua",
        "php",
        "python",
        "rust",
        "typescript",
        "yaml",
        "markdown",
        "markdown_inline",
        "vim",
        "gitignore",
        "diff",
        "fish",
        "vimdoc",
        "haskell",
        "hyprlang",
        "kdl",
      })
      require("nvim-ts-autotag").setup()
      ts_loaded = true
    end
    pcall(vim.treesitter.start)
  end,
})
