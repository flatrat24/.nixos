{ pkgs, lib, config, ... }: {
  options = {
    neovim.plugins.leap = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.leap.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.leap = {
          enable = true;
        };
      };
    }
  ]);
}
