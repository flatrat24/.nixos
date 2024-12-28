{ pkgs, lib, config, ... }:
let
  cfg = config.neovim.plugins.transparent;
in {
  options = {
    neovim.plugins.transparent = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.nixvim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.transparent = {
          enable = true;
        };
      };
    }
  ]);
}
