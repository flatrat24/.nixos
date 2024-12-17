{ pkgs, lib, config, ... }: {
  options = {
    neovim.plugins.web-devicons = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.web-devicons.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.web-devicons = {
          enable = true;
        };
      };
    }
  ]);
}
