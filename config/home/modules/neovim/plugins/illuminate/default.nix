{ lib, config, ... }:
let
  cfg = config.neovim.plugins.illuminate;
in {
  options = {
    neovim.plugins.illuminate = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.nixvim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins.illuminate = {
        enable = true;
        delay = 100;
        filetypesDenylist = [
          "dashboard"
          "gitcommit"
          "oil"
        ];
      };
    };
  };
}
