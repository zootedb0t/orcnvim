  local cmp_status_ok, cmp = pcall(require, "cmp")
  local snip_status_ok, luasnip = pcall(require, "luasnip")
  local autopair_ok, autopair = pcall(require, "nvim-autopairs.completion.cmp")
  if cmp_status_ok and snip_status_ok then
    local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }
    local kind_icons = require("core.icons").kind

    cmp.setup({
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
          local col = vim.fn.col(".") - 1

          if cmp.visible() then
            cmp.select_next_item(cmp_select_opts)
          elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
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
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "nvim_lsp_signature_help" },
        { name = "buffer", keyword_length = 2 },
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
