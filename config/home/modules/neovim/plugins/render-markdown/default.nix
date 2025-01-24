{ lib, config, ... }:
let
  cfg = config.neovim.plugins.render-markdown;
in {
  options = {
    neovim.plugins.render-markdown = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.nixvim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.render-markdown = {
          enable = true;
          settings = {
            heading = {
              border = false;
              icons = [
                "󰎦 "
                "󰎩 "
                "󰎬 "
                "󰎮 "
                "󰎰 "
                "󰎵 "
              ];
              position = "overlay";
              sign = false;
              width = "full";
            };
            paragraph = {
              enabled = true;
              left_margin = 0;
              min_width = 0;
            };
            bullet = {
              icons = [
                " "
                " "
                " "
                # " "
                # " "
                # " "
              ];
              right_pad = 1;
            };
            checkbox = {
              enabled = true;
              render_modes = false;
              position = "inline";
              unchecked = {
                icon = " ";
                highlight = "CurSearch";
                scope_highlight = "nil";
              };
              checked = {
                icon = " ";
                highlight = "RenderMarkdownChecked";
                scope_highlight = "nil";
              };
            };
            render_modes = true;
            signs = {
              enabled = true;
            };
            indent = {
              enabled = false;
              render_modes = false;
              per_level = 0;
              skip_level = 0;
              skip_heading = false;
            };
          };
        };
      };
    }
  ]);
}
