return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {},
  config = function()
    require("which-key").setup({
      preset = "modern",
      delay = 500,
      -- modes = {
      --   n = true, -- Normal mode
      --   i = false, -- Insert mode
      --   x = false, -- Visual mode
      --   s = false, -- Select mode
      --   o = false, -- Operator pending mode
      --   t = false, -- Terminal mode
      --   c = false, -- Command mode
      -- },
      icons = {
        rules = false
      }
    })
    local wk = require("which-key")
    wk.add({
      { "<leader>f", group = "File Management" },
      { "<leader>g", group = "Git Management" },
      { "<leader>v", group = "View Management" },
      { "<leader>",  group = "Leader Keybinds" },
      { "g",         group = "Go To" },
      { "z",         group = "Folds" },
      { "'",         group = "Marks" },
      { "`",         group = "Marks" },
      { "\"",         group = "Registers" },
      { "<c-w>",     group = "Window Management" },
      { "[",         group = "Backward" },
      { "]",         group = "Forward" },
    })
  end
}
