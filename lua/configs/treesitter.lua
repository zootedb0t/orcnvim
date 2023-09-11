local ts_ok, ts_config = pcall(require, "nvim-treesitter.configs")
if ts_ok then
  ts_config.setup({
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
      max_file_lines = 2000,
    },
    incremental_selection = {
      enable = true,
    },
    indent = { enable = true, disable = { "yaml", "python", "c", "cpp" } },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]k"] = { query = "@block.outer", desc = "Next block start" },
          ["]f"] = { query = "@function.outer", desc = "Next function start" },
          ["]a"] = { query = "@parameter.inner", desc = "Next parameter start" },
        },
        goto_next_end = {
          ["]K"] = { query = "@block.outer", desc = "Next block end" },
          ["]F"] = { query = "@function.outer", desc = "Next function end" },
          ["]A"] = { query = "@parameter.inner", desc = "Next parameter end" },
        },
        goto_previous_start = {
          ["[k"] = { query = "@block.outer", desc = "Previous block start" },
          ["[f"] = { query = "@function.outer", desc = "Previous function start" },
          ["[a"] = { query = "@parameter.inner", desc = "Previous parameter start" },
        },
        goto_previous_end = {
          ["[K"] = { query = "@block.outer", desc = "Previous block end" },
          ["[F"] = { query = "@function.outer", desc = "Previous function end" },
          ["[A"] = { query = "@parameter.inner", desc = "Previous parameter end" },
        },
      },
    },
  })
end
