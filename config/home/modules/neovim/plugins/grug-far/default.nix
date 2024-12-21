{ lib, config, ... }: {
  options = {
    neovim.plugins.grug-far = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.grug-far.enable {
    programs.nixvim = {
      plugins.grug-far = {
        enable = true;
      };
    };
  };
}
