{ pkgs, lib, config, ... }: {
  options = {
    neovim.plugins.nvim-surround = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = {
    programs.nixvim = {
      plugins.nvim-surround = {
        enable = true;
      };
    };
  };
}
