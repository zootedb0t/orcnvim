local cmp_status_ok, cmp = pcall(require, "cmp")
local snip_status_ok, luasnip = pcall(require, "luasnip")
local autopair_ok, autopair = pcall(require, "nvim-autopairs.completion.cmp")
local kind_icons = require("core.icons").kind
local border_opts = {
  border = "single",
  winhighlight = "Normal:CmpPmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
}

-- Override cmp highlight
require("core.ui.highlight").cmp_highlight()

local function check_back_space()
  local col = vim.fn.col(".") - 1 -- This returns current column position
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then -- vim.fn.getline gives current line
    return true
  else
    return false
  end
end

local ELLIPSIS_CHAR = require("core.icons").ui.Ellipsis
local MAX_LABEL_WIDTH = 25

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

if cmp_status_ok and snip_status_ok then
  local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

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
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
      -- toggle completion
      ["<C-e>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.close()
          fallback()
        else
          cmp.complete()
        end
      end),

      -- go to next placeholder in the snippet
      ["<C-d>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end, { "i", "s" }),

      -- go to previous placeholder in the snippet
      ["<C-b>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),

      -- ["<CR>"] = cmp.mapping.confirm({ select = false }),
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
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item(cmp_select_opts)
        elseif check_back_space() then
          fallback()
        else
          cmp.complete()
        end
      end, { "i", "s" }),

      -- when menu is visible, navigate to previous item on list
      -- else, revert to default behavior
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item(cmp_select_opts)
        else
          fallback()
        end
      end, { "i", "s" }),
    },

    sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 1000 },
      { name = "luasnip", priority = 750 },
      { name = "buffer", priority = 500 },
      { name = "path", priority = 250 },
      { name = "nvim_lsp_signature_help" },
    }),

    -- don't sort double underscore things first
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },

    duplicates = {
      buffer = 1,
      path = 1,
      nvim_lsp = 0,
      luasnip = 1,
    },

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
end
if autopair_ok then
  cmp.event:on("confirm_done", autopair.on_confirm_done({ map_char = { tex = "" } }))
end
