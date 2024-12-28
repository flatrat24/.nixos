# TODO: Get which-key groups and a general keybind working

{ lib, config, ... }:
let
  cfg = config.neovim.plugins.which-key;
in {
  options = {
    neovim.plugins.which-key = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.nixvim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.which-key = {
          enable = true;
          settings = {
            delay = 1000;
            preset = "modern";
            expand = 1;
            replace = {
              desc = [
                [
                  "<space>"
                  "SPACE"
                ]
                [
                  "<leader>"
                  "SPACE"
                ]
                [
                  "<[cC][rR]>"
                  "RETURN"
                ]
                [
                  "<[tT][aA][bB]>"
                  "TAB"
                ]
                [
                  "<[bB][sS]>"
                  "BACKSPACE"
                ]
              ];
            };
            win = {
              border = "single";
            };
          };
        };
      };
    }
  ]);
}
