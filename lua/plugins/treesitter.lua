return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    dependencies = {
      "hiphish/rainbow-delimiters.nvim",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    -- If you put config in opts, some treesitter
    -- parsers don't work
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
          "c",
          "comment",
          "cmake",
          "cpp",
          "css",
          "go",
          "html",
          "javascript", -- Very buggy.
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
        },
        autotag = {
          enable = true,
          filetypes = {
            "html",
            "javascript",
            "typescript",
            "markdown",
          },
        },
        highlight = {
          enable = true,
          disable = function(_, bufnr)
            local max_filesize = 100 * 1024 -- 100 KB
            return vim.fn.getfsize(vim.fn.bufname(bufnr)) > max_filesize
          end,
        },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = 1000,
        },
        incremental_selection = {
          enable = true,
        },
        indent = { enable = true, disable = { "yaml", "python", "c", "cpp" } },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      })
    end,
  },
}
