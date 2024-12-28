{ pkgs, lib, config, ... }:
let
  cfg = config.neovim.plugins.indent-blankline;
in {
  options = {
    neovim.plugins.indent-blankline = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.nixvim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.indent-blankline = {
          enable = true;
        };
        extraConfigLua = ''
          local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
          }

          local hooks = require "ibl.hooks" -- create the highlight groups in the highlight setup hook, so they are reset -- every time the colorscheme changes
          hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#53394D" })    -- #F38BA8
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#554F4E" }) -- #F9E2AF
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#394461" })   -- #89B4FA
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#554344" }) -- #FAB387
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#404F4B" })  -- #A6E3A1
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#444662" }) -- #B4BEFE
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#3C4F58" })   -- #94E2D5
          end)

          require("ibl").setup {
            indent = {
              highlight = highlight,
            },
            scope = {
              enabled = false,
              show_start = false,
              show_end = false,
            },
            exclude = {
              filetypes = {
                "",
                "help",
                "dashboard",
              },
              buftypes = { },
            },
          }
        '';
      };
    }
  ]);
}
