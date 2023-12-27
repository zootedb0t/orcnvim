local options = {
  opt = {
    clipboard = { "unnamedplus" }, -- Connection to the system clipboard
    completeopt = { "menu", "popup" }, -- Options for insert mode completion
    copyindent = true, -- Copy the previous indentation on autoindenting
    cursorline = true, -- Highlight the text line of the cursor
    cursorlineopt = "number", -- This looks better
    fillchars = {
      eob = " ",
    },
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
    guicursor = vim.opt.guicursor + { "a:blinkon100" }, -- Fix blinking cursor
    smartcase = true, -- Case sensitivie searching
    grepprg = "rg --hidden --vimgrep --smart-case --", -- Replace Vimgrep with Ripgrep   hlsearch = true,
    splitbelow = true, -- Splitting a new window below the current one
    splitright = true, -- Splitting a new window at the right of the current one
    splitkeep = "screen", -- Maintain code view when splitting
    swapfile = false, -- Disable use of swapfile for the buffer
    tabstop = 2, -- Number of space in a tab
    timeoutlen = 500, -- Length of time to wait for a mapped sequence
    updatetime = 300, -- Length of time to wait before triggering the plugin
    wrap = false, -- Disable wrapping of lines longer than the width of window
    writebackup = false, -- Disable making a backup before overwriting a file
    title = true,
    jumpoptions = "stack",
    cmdheight = 0, -- Hide cmdheight after issue #16251
    ls = 3, -- Global statusline
    shell = "/usr/bin/sh",
    inccommand = "split", -- incrementally show result of command
    wildignore = vim.opt.wildignore + { "*.o", "*~", "*.pyc", "*pycache*" }, -- Ignore compiled files
    wildoptions = "pum", -- Cool floating window popup menu for completion on command line
    diffopt = vim.opt.diffopt + { "linematch:50" },
    statusline = "%{%v:lua.require'core.ui.statusline'.draw()%}",
    winbar = "%{%v:lua.require'core.ui.winbar'.draw()%}",
    statuscolumn = "%{%v:lua.require'core.ui.statuscolumn'.draw()%}",
    numberwidth = 3,
    foldcolumn = "1",
    foldlevelstart = 99,
    foldmethod = "expr",
    foldexpr = "v:lua.vim.treesitter.foldexpr()",
    foldtext = "v:lua.vim.treesitter.foldtext()",
    smoothscroll = true,
  },

  g = {
    mapleader = " ",
    maplocalleader = ",",
    transparent_nvim = false, -- Set true to make window transparent
  },
}

for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end
