{ pkgs, lib, config, ... }: {
  options = {
    neovim.plugins.nvim-surround = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.nvim-surround.enable {
    programs.nixvim = {
      plugins.nvim-surround = {
        enable = true;
      };
    };
  };
}
