{ pkgs, lib, config, ... }: {
  options = {
    neovim.plugins.trouble = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.trouble.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.trouble = {
          enable = true;
        };
      };
    }
  ]);
}
