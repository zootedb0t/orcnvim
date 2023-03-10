local M = {}

local options = {
  opt = {
    clipboard = { "unnamedplus" }, -- Connection to the system clipboard
    completeopt = { "menu", "menuone", "noselect" }, -- Options for insert mode completion
    copyindent = true, -- Copy the previous indentation on autoindenting
    cursorline = false, -- Highlight the text line of the cursor
    cursorlineopt = "number", -- This looks better
    fileencoding = "utf-8", -- File content encoding for the buffer
    expandtab = true, -- Enable the use of space in tab
    fillchars = {
      eob = " ",
      horiz = "━", -- '▃',--'═', --'─',
      horizup = "┻", -- '╩',-- '┴',
      horizdown = "┳", -- '╦', --'┬',
      vert = "┃", -- '▐', --'║', --'┃',
      vertleft = "┨", -- '╣', --'┤',
      vertright = "┣", -- '╠', --'├',
      verthoriz = "╋", -- '╬',--'┼','
    }, -- Disable `~` on nonexistent lines
    history = 100, -- Number of commands to remember in a history table
    ignorecase = true, -- Case insensitive searching
    mouse = "nv", -- Enable mouse support
    number = true, -- Show numberline
    preserveindent = true, -- Preserve indent structure as much as possible
    pumheight = 10, -- Height of the pop up menu
    relativenumber = true, -- Show relative numberline
    scrolloff = 4, -- Number of lines to keep above and below the cursor
    shiftwidth = 2, -- Number of space inserted for indentation
    showmode = false, -- Disable showing modes in command line
    sidescrolloff = 4, -- Number of columns to keep at the sides of the cursor
    signcolumn = "yes", -- Always show the sign column
    guicursor = vim.opt.guicursor + { "a:blinkon100" }, -- Fix for blinking cursor
    smartcase = true, -- Case sensitivie searching
    grepprg = "rg --hidden --vimgrep --smart-case --", -- Replace Vimgrep with Ripgrep   hlsearch = true,
    splitbelow = true, -- Splitting a new window below the current one
    splitright = true, -- Splitting a new window at the right of the current one
    splitkeep = "screen", -- Maintain code view when splitting
    swapfile = false, -- Disable use of swapfile for the buffer
    tabstop = 2, -- Number of space in a tab
    termguicolors = true, -- Enable 24-bit RGB color in the TUI
    timeoutlen = 300, -- Length of time to wait for a mapped sequence
    updatetime = 50, -- Length of time to wait before triggering the plugin
    wrap = false, -- Disable wrapping of lines longer than the width of window
    writebackup = false, -- Disable making a backup before overwriting a file
    title = true,
    jumpoptions = "stack",
    cmdheight = 0, -- Hide cmdheight after issue #16251
    ls = 3, -- Global statusline
    shell = "/usr/bin/sh",
    inccommand = "split", -- incrementally show result of command
    -- Ignore compiled files
    wildignore = vim.opt.wildignore + { "*.o", "*~", "*.pyc", "*pycache*" },
    -- Cool floating window popup menu for completion on command line
    wildoptions = "pum",
    --list = true, -- Show some invisible characters
    --listchars = { tab = " ", trail = "·" },
    diffopt = vim.opt.diffopt + { "linematch:50" },
    -- numberwidth = 3,
    -- statuscolumn = "%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%=%s",
    synmaxcol = 120,
  },

  g = {
    highlighturl_enabled = true, -- highlight URLs by default
    mapleader = " ",
    transparent_nvim = true, -- Set true to make window transparent
  },
}

for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end

return M
