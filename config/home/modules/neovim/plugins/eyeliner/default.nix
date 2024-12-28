{ pkgs, lib, config, ... }:
let
  cfg = config.neovim.plugins.eyeliner;
in {
  options = {
    neovim.plugins.eyeliner = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.nixvim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.nixvim = {
        extraPlugins = with pkgs.vimPlugins; [
          eyeliner-nvim
        ];
        extraConfigLua = ''
          require('eyeliner').setup({
            highlight_on_key = true;
            dim = true;
          })
        '';
      };
    }
  ]);
}
