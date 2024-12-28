{ pkgs, lib, config, ... }:
let
  cfg = config.neovim.plugins.lualine;
in {
  options = {
    neovim.plugins.lualine = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.nixvim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins.lualine = {
        enable = true;
        settings = {
          options = {
            disabled_filetypes = {
              statusline = [
                "dashboard"
                "neo-tree"
                "trouble"
                "undotree"
                "diff"
                "qf"
              ];
            };
          };
        };
      };
    };
  };
}
