local term_ok, term = pcall(require, "toggleterm")

if term_ok then
  term.setup({
    -- active = true,
    size = 15,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    close_on_exit = true, -- close the terminal window when the process exits
    open_mapping = [[<c-\>]],
    border = "double",
    shell = "/usr/bin/fish",
  })
end
