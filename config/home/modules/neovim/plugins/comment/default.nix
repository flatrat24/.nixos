{ lib, config, ... }: {
  options = {
    neovim.plugins.comment = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.comment.enable {
    programs.nixvim = {
      plugins.comment = {
        enable = true;
      };
    };
  };
}
