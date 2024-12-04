return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "html",
        "hyprlang",
        "json",
        "kdl",
        "lua",
        "markdown",
        "markdown_inline",
        "nix",
        "python",
        "query",
        "rasi",
        "vim",
        "vimdoc",
        "yaml",
      },
      highlight = {
        enable = true,
        disable = {
          "latex",
        },
      },
      highlight = {enable = true},
      indent = {enable = true},
    })
  end
}
