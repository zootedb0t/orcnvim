return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    lazy = false,
    dependencies = {
      -- "hiphish/rainbow-delimiters.nvim", -- WARN This degrades performance
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
      "windwp/nvim-ts-autotag",
    },

    config = function()
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
      })
    end,
  },
}
