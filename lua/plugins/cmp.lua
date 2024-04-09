local cmp = require("cmp")
local icons = require("core.icons")
local MAX_LABEL_WIDTH = 25

local get_ws = function(max, len)
  return string.rep(" ", (max - len))
end

-- Format for cmp popup menu to have fixed width
local menu_format = function(_, item)
  local content = item.abbr
  item.kind = string.format("%s %s", icons.kind[item.kind], item.kind)
  -- item.menu = ({
  --   buffer = "[buf]",
  --   nvim_lsp = "[lsp]",
  -- 	 luasnip = "[snip]",
  --   snippets = "[snip]",
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
    format = menu_format,
  },

  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
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
      elseif vim.snippet.jumpable(1) then
        vim.snippet.jump(1)
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
      elseif vim.snippet.jumpable(-1) then
        vim.snippet.jump(-1)
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
    { name = "snippets" },
    { name = "buffer" },
    { name = "path" },
    { name = "nvim_lsp_signature_help" },
  }),

  window = {
    completion = {
      winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
      scrollbar = false,
      border = "single",
    },
  },
})
