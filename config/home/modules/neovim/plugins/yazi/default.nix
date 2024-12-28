{ lib, config, ... }:
let
  cfg = config.neovim.plugins.yazi;
in {
  options = {
    neovim.plugins.yazi = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.nixvim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      plugins.yazi.enable = true;
      keymaps = [
        { mode = [ "n" ]; key = "<leader>o"; action = "<cmd>Yazi<CR>"; options = { noremap = true; silent = true; desc = "Open Yazi"; }; }
      ];
    };
  };
}
