{ pkgs, lib, config, ... }: {
  options = {
    neovim.plugins.eyeliner = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.eyeliner.enable (lib.mkMerge [
    {
      programs.nixvim = {
        extraPlugins = with pkgs.vimPlugins; [
          eyeliner-nvim
        ];
        extraConfigLua = ''require('eyeliner').setup({
          highlight_on_key = true;
          dim = true;
        })'';
      };
    }
  ]);
}
