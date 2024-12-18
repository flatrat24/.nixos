{ pkgs, lib, config, ... }: {
  options = {
    neovim.plugins.comment = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = {
    programs.nixvim = {
      plugins.comment = {
        enable = true;
      };
    };
  };
}
