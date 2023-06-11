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
      -- extended_mode = true,
    },
    incremental_selection = {
      enable = true,
    },
    indent = { enable = true, disable = { "yaml", "python", "c", "cpp" } },
    textobjects = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
    },
  })
end
