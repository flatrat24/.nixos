{ lib, config, ... }:
let
  cfg = config.neovim.plugins.comment;
in {
  options = {
    neovim.plugins.comment = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.nixvim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins.comment = {
        enable = true;
        settings = {
          opleader = {
            line = "x";
            block = "X";
          };
        };
      };
    };
  };
}
