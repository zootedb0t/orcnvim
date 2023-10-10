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
    move = {
      enable = true,
      goto_next_start = {
        ["]f"] = { query = "@function.outer", desc = "Start of function start" },
        ["]b"] = { query = "@block.outer", desc = "Start of block" },
        ["]p"] = { query = "@parameter.inner", desc = "Start of parameter" },
        ["]c"] = { query = "@class.outer", desc = "Start of class" },
      },
      goto_next_end = {
        ["]F"] = { query = "@function.outer", desc = "End of function" },
        ["]B"] = { query = "@block.outer", desc = "End of block" },
        ["]P"] = { query = "@parameter.inner", desc = "End of parameter" },
        ["]C"] = { query = "@class.outer", desc = "End of class" },
      },
      goto_previous_start = {
        ["[f"] = { query = "@function.outer", desc = "Previous function start" },
        ["[b"] = { query = "@block.outer", desc = "Previous block start" },
        ["[p"] = { query = "@parameter.inner", desc = "Previous parameter start" },
        ["[c"] = { query = "@class.outer", desc = "Previous class" },
      },
      goto_previous_end = {
        ["[F"] = { query = "@function.outer", desc = "Previous function end" },
        ["[B"] = { query = "@block.outer", desc = "Previous block end" },
        ["[P"] = { query = "@parameter.inner", desc = "Previous parameter end" },
        ["[C"] = { query = "@class.outer", desc = "Previous class end" },
      },
    },
  },
})
