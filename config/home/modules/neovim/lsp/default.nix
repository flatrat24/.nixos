{ pkgs, lib, config, ... }: {
  options = {
    neovim.plugins.lsp = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = {
    programs.nixvim = {
      plugins.lsp.enable = true;
    };
  };
}
