{ pkgs, lib, config, ... }:
let
  cfg = config.neovim.plugins.aerial;
in {
  options = {
    neovim.plugins.aerial = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.nixvim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      extraPlugins = with pkgs.vimPlugins; [
        aerial-nvim
      ];
        extraConfigLua = ''
          require('aerial').setup({ })
        '';
      keymaps = [
        { mode = [ "n" ]; key = "<leader>vo"; action = "<cmd>AerialToggle<CR>"; options = { noremap = true; silent = true; desc = "View Code Outline"; }; }
      ];
    };
  };
}
