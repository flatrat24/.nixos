{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [ ];
in {
  options = {
    neovim.plugins.yazi = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.yazi.enable {
    programs.nixvim = {
      plugins.yazi.enable = true;
      keymaps = [
        { mode = [ "n" ]; key = "<leader>o"; action = "<cmd>Yazi<CR>"; options = { noremap = true; silent = true; desc = "Open Yazi"; }; }
      ];
    };
  };
}
