local cmp = require("cmp")
local luasnip = require("luasnip")
local icons = require("core.icons")
local MAX_LABEL_WIDTH = 25

local get_ws = function(max, len)
  return string.rep(" ", (max - len))
end

-- Format for cmp popup menu to have fixed width
local format = function(_, item)
  local content = item.abbr
  item.kind = string.format("%s %s", icons.kind[item.kind], item.kind)
  -- item.menu = ({
  --   buffer = "[buf]",
  --   nvim_lsp = "[lsp]",
  --   luasnip = "[snip]",
  --   path = "[path]",
  -- })[entry.source.name]

  -- #content gives size of string
  if #content > MAX_LABEL_WIDTH then
    -- Returns string Like |strpart()| but using character index (start form 0) and length instead
    -- of byte index and length.
    item.abbr = vim.fn.strcharpart(content, 0, MAX_LABEL_WIDTH) .. icons.ui.Ellipsis
  else
    item.abbr = content .. get_ws(MAX_LABEL_WIDTH, #content)
  end
  return item
end

cmp.setup({
  formatting = {
    format = format,
  },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
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
    end, {
      "i",
      "s",
    }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "nvim_lsp_signature_help" },
  }),

  window = {
    completion = cmp.config.window.bordered({
      scrollbar = false,
      winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
      border = "single",
    }),
    documentation = cmp.config.window.bordered({
      border = "single",
    }),
  },
})
