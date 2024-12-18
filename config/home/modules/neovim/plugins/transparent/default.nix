{ pkgs, lib, config, ... }: {
  options = {
    neovim.plugins.transparent = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.transparent.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.transparent = {
          enable = true;
        };
      };
    }
  ]);
}
