local cmp = require("cmp")
local luasnip = require("luasnip")
local kind_icons = require("core.icons").kind
local ELLIPSIS_CHAR = require("core.icons").ui.Ellipsis
local MAX_LABEL_WIDTH = 25

local border_opts = {
  border = "single",
  winhighlight = "Normal:CmpPmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
}

local get_ws = function(max, len)
  return (" "):rep(max - len) -- Add whitespace (max-len) times
end

-- Format for cmp popup menu to have fixed width
local format = function(entry, item)
  local content = item.abbr
  item.kind = string.format("%s %s", kind_icons[item.kind], item.kind)
  item.menu = ({
    buffer = "[BUF]",
    nvim_lsp = "[LSP]",
    luasnip = "[SNIP]",
    path = "[PATH]",
  })[entry.source.name]

  -- #content gives size of string
  if #content > MAX_LABEL_WIDTH then
    -- Returns string Like |strpart()| but using character index (start form 0) and length instead
    -- of byte index and length.
    item.abbr = vim.fn.strcharpart(content, 0, MAX_LABEL_WIDTH) .. ELLIPSIS_CHAR
  else
    item.abbr = content .. get_ws(MAX_LABEL_WIDTH, #content)
  end

  return item
end

cmp.setup({
  completion = {
    ---@usage The minimum length of a word to complete on.
    keyword_length = 1,
  },

  formatting = {
    format = format,
  },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = {
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-c>"] = cmp.mapping.abort(),

    ["<CR>"] = cmp.mapping(function(fallback)
      if cmp.visible() and cmp.get_selected_entry() then
        cmp.confirm({ select = false })
      elseif cmp.visible() then
        cmp.close()
      else
        fallback()
      end
    end),

    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

    -- go to next placeholder in the snippet
    ["<C-n>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    -- go to previous placeholder in the snippet
    ["<C-p>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    -- when menu is visible, navigate to previous item on list
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      elseif cmp.visible() then
        cmp.select_prev_item()
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
    completion = cmp.config.window.bordered({
      side_padding = 1,
      scrollbar = false,
      border_opts,
    }),
    documentation = cmp.config.window.bordered({
      border_opts,
    }),
  },
})
