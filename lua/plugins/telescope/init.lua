local telescope = require("telescope")
local icon = require("core.icons")

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
  defaults = {
    prompt_prefix = icon.ui.Search .. " ",
    selection_caret = icon.ui.ChevronRight .. " ",
    color_devicons = true,
    sorting_strategy = "ascending",
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      vertical = {
        mirror = false,
      },
      width = 0.75,
      height = 0.65,
      preview_cutoff = 120,
    },
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-d>"] = actions.delete_buffer,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<CR>"] = actions.select_default,
        -- Show dotfiles
        ["<a-h>"] = function()
          builtin.find_files({
            hidden = true,
          })
        end,
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-d>"] = actions.delete_buffer,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
  },
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_mru = true,
      previewer = false,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
    file_browser = {
      theme = "ivy",
      hijack_netrw = false,
      files = false,
    },
  },
})

-- Extensions for telescope
telescope.load_extension("fzf")
telescope.load_extension("file_browser")
telescope.load_extension("persisted")
