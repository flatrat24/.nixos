return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = false,
        emphasis = false,
        comments = true,
        operators = false,
        folds = false,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      dim_inactive = false,
      transparent_mode = false,
      overrides = {
        FloatBorder        = {bg = "#282828"},
        NormalFloat        = {bg = "#282828"},
        Pmenu              = {bg = "#282828"},
        DiagnosticSignHint = {bg = "#282828", fg = "#8EC07C"},
      }
    })
    vim.cmd("colorscheme gruvbox")
  end
}
