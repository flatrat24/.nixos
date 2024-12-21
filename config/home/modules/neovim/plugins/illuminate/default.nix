{ lib, config, ... }: {
  options = {
    neovim.plugins.illuminate = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.illuminate.enable {
    programs.nixvim = {
      plugins.illuminate = {
        enable = true;
        delay = 100;
        filetypesDenylist = [
          "dashboard"
          "gitcommit"
          "oil"
        ];
      };
    };
  };
}
