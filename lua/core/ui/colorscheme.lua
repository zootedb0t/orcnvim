local cmd = vim.api.nvim_create_autocmd

-- For colorscheme that don't support transparency. Set transparent_nvim value in options.lua.
if vim.g.transparent_nvim then
  cmd("ColorScheme", {
    pattern = "*",
    callback = function()
      local hl_group = {
        "Normal",
        "SignColumn",
        "TelescopeBorder",
        "TelescopeNormal",
        "TelescopePromptNormal",
        "WhichKeyFloat",
        "NormalFloat",
        "NormalNC",
        "NvimTreeNormal",
        "NvimTreeNormalNC",
        "EndOfBuffer",
        "MsgArea",
        "VertSplit",
        "FloatBorder",
        "LineNr",
        "WinBar",
      }
      for _, name in ipairs(hl_group) do
        vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
      end
    end,
  })
end

-- Setting colorscheme
vim.cmd.colorscheme "citruszest"
