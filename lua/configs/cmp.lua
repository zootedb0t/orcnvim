local M = {}

function M.config()
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  --   פּ ﯟ   some other good icons
  local cmp_status_ok, cmp = pcall(require, "cmp")
  local snip_status_ok, luasnip = pcall(require, "luasnip")
  local autopair_ok, autopair = pcall(require, "nvim-autopairs.completion.cmp")
  if cmp_status_ok and snip_status_ok then
    local kind_icons = {
      -- These icons work in patched font
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "",
      Variable = "",
      Class = "",
      Interface = "",
      Module = "",
      Property = "",
      Unit = "",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "",
      Event = "",
      Operator = "",
      TypeParameter = "",
    }

    cmp.setup({
      -- formatting = {
      -- 	fields = { "menu", "abbr", "kind" },
      -- 	format = function(entry, item)
      -- 		local menu_icon = {
      -- 			nvim_lsp = "λ",
      -- 			luasnip = "⋗",
      -- 			buffer = "Ω",
      -- 			path = "🖫",
      -- 		}

      -- 		item.menu = menu_icon[entry.source.name]
      -- 		return item
      -- 	end,
      -- },

      formatting = {
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
          vim_item.menu = ({
            buffer = "[BUF]",
            nvim_lsp = "[LSP]",
            luasnip = "[SNIP]",
            path = "[PATH]",
          })[entry.source.name]
          return vim_item
        end,
      },

      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },

      cmp = {
        source_priortiy = {
          nvim_lsp = 1000,
          snippy = 500,
          buffer = 250,
          path = 200,
        },
      },

      mapping = {
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),

        -- ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() and cmp.get_selected_entry() then
            cmp.confirm()
          elseif cmp.visible() then
            cmp.close()
          else
            fallback()
          end
        end),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "nvim_lsp_signature_help" },
        { name = "buffer", keyword_length = 2 },
      }),

      -- view = {
      --   entries = "native",
      -- },

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

      window = {
        completion = cmp.config.window.bordered({
          -- col_offset = 2,
          side_padding = 1,
          border = {
            "┌",
            "─",
            "┐",
            "│",
            "┘",
            "─",
            "└",
            "│",
          },
        }),
        documentation = cmp.config.window.bordered({
          border = {
            "┌",
            "─",
            "┐",
            "│",
            "┘",
            "─",
            "└",
            "│",
          },
        }),
      },
    })
  end
  if autopair_ok then
    cmp.event:on("confirm_done", autopair.on_confirm_done({ map_char = { tex = "" } }))
  end
end

return M
