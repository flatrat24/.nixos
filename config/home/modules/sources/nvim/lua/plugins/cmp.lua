return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-.>"]     = cmp.mapping.scroll_docs(-4),
          ["<C-,>"]     = cmp.mapping.scroll_docs(4),
          ["<C-l>"]     = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-h>"]     = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-S-h>"]   = cmp.mapping.abort(),
          ["<C-S-l>"]   = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "path" },
          { name = "buffer", keyword_length = 5 },
          { name = "luasnip"},
        }),
      })
    end,
  },
}
