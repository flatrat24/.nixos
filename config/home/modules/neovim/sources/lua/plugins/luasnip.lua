-- return {}

return {
  "L3MON4D3/LuaSnip",
  config = function()
    local ls = require("luasnip")
    local types = require("luasnip.util.types")
    ls.config.setup({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
      store_selection_keys = "<c-k>",

      require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})

      -- ext_opts = nil,
      -- ext_opts = {
      --     [types.choideNode] = {
      --         active = {
      --             virt_text = { { "<-", "Error" } },
      --         },
      --     },
      -- },

    })
  end,
}
