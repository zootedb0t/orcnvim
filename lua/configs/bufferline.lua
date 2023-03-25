local status_ok, bufferline = pcall(require, "bufferline")
if status_ok then
  bufferline.setup({
    options = {
      offsets = {
        {
          filetype = "NvimTree",
          text = "",
          -- highlight = "PanelHeading",
          padding = 1,
        },
      },
    },
  })
end
