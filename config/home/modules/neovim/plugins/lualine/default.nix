{ pkgs, lib, config, ... }: {
  options = {
    neovim.plugins.lualine = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = {
    programs.nixvim = {
      plugins.lualine = {
        enable = true;
        settings = {
          options = {
            disabled_filetypes = {
              statusline = [ "dashboard" ];
            };
          };
        };
      };
    };
  };
}
