{ pkgs, lib, config, ... }:
let
  cfg = config.neovim.plugins.web-devicons;
in {
  options = {
    neovim.plugins.web-devicons = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.nixvim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.web-devicons = {
          enable = true;
        };
      };
    }
  ]);
}
