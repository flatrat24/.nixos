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
          settings = { };
        };
      };
    }
  ]);
}
