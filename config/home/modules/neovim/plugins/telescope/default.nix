{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [ ];
in {
  options = {
    neovim.plugins.telescope = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.telescope.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.telescope = {
          enable = true;
          extensions.fzf-native = { enable = true; };
        };
        keymaps = [
          { mode = [ "n" ]; key = "<leader>bg"; action = "<cmd>Yazi<CR>"; options = { noremap = true; silent = true; desc = "Live grep"; }; }
        ];
      };
    }
  ]);
}

