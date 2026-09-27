local term_loaded = false

local function toggle_term()
  if not term_loaded then
    vim.pack.add({ "https://github.com/akinsho/toggleterm.nvim" })
    require("toggleterm").setup({
      size = 15,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      close_on_exit = true, -- close the terminal window when the process exits
      border = "double",
      shell = "/usr/bin/fish",
    })
    term_loaded = true
  end
  require("toggleterm").toggle()
end

vim.keymap.set("n", "<leader>at", toggle_term, { desc = "Open Terminal" })
