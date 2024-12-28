{ pkgs, lib, config, ... }:
let
  cfg = config.neovim.plugins.nvim-surround;
in {
  options = {
    neovim.plugins.nvim-surround = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.nixvim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins.nvim-surround = {
        enable = true;
      };
    };
  };
}
