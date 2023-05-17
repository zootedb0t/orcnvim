local M = {}

-- For autopairs
M.pair = function()
  local pairs_ok, pairs = pcall(require, "nvim-autopairs")
  if pairs_ok then
    pairs.setup({
      check_ts = true,
      disable_filetype = { "TelescopePrompt" },
      enable_check_bracket_line = false,
      ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
      fast_wrap = {
        -- map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    })
  end
end

M.hop = function()
  local hop_ok, hop = pcall(require, "hop")
  if hop_ok then
    hop.setup({
      keys = "etovxqpdygfblzhckisuran",
    })
  end
end

M.web_tools = function()
  local status_ok, web_tools = pcall(require, "web-tools")
  if status_ok then
    web_tools.setup()
  end
end

M.peek = function()
  local peek_ok, peek = pcall(require, "peek")
  if peek_ok then
    peek.setup({
      auto_load = true, -- whether to automatically load preview when
      -- entering another markdown buffer
      close_on_bdelete = true, -- close preview window on buffer delete
      syntax = true, -- enable syntax highlighting, affects performance
      theme = "dark", -- 'dark' or 'light'
      update_on_change = true,
      -- relevant if update_on_change is true
      throttle_at = 200000, -- start throttling when file exceeds this
      -- amount of bytes in size
      throttle_time = "auto",
    })
    vim.api.nvim_create_user_command("PeekOpen", peek.open, {})
    vim.api.nvim_create_user_command("PeekClose", peek.close, {})
  end
end

return M
