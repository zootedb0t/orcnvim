local cmp = require("cmp")
local icons = require("core.icons")
local MAX_ABBR_WIDTH, MAX_MENU_WIDTH = 25, 30

-- Format for cmp popup menu to have fixed width
local menu_format = function(_, item)
  item.kind = string.format("%s %s", icons.kind[item.kind], item.kind)
  if vim.api.nvim_strwidth(item.abbr) > MAX_ABBR_WIDTH then
    item.abbr = vim.fn.strcharpart(item.abbr, 0, MAX_ABBR_WIDTH) .. " " .. icons.ui.Ellipsis
  end

  if vim.api.nvim_strwidth(item.menu or "") > MAX_MENU_WIDTH then
    item.menu = vim.fn.strcharpart(item.menu, 0, MAX_MENU_WIDTH) .. " " .. icons.ui.Ellipsis
  end
  return item
end

cmp.setup({
  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = menu_format,
  },

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  view = {
    entries = {
      follow_cursor = true,
    },
  },

  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-c>"] = cmp.mapping.abort(),

    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "nvim_lsp_signature_help" },
  }),

  window = {
    completion = {
      winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
      scrollbar = false,
      border = {
        { "󱐋", "WarningMsg" },
        { "─", "Comment" },
        { "╮", "Comment" },
        { "│", "Comment" },
        { "╯", "Comment" },
        { "─", "Comment" },
        { "╰", "Comment" },
        { "│", "Comment" },
      },
    },
    documentation = {
      border = {
        { "󰙎", "DiagnosticHint" },
        { "─", "Comment" },
        { "╮", "Comment" },
        { "│", "Comment" },
        { "╯", "Comment" },
        { "─", "Comment" },
        { "╰", "Comment" },
        { "│", "Comment" },
      },
    },
  },
})
