{ pkgs, lib, config, ... }:
let
  cfg = config.neovim.plugins.nvim-highlight-colors;
in {
  options = {
    neovim.plugins.nvim-highlight-colors = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.nixvim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.nixvim = {
        extraPlugins = with pkgs.vimPlugins; [
          nvim-highlight-colors
        ];
        extraConfigLua = ''
          require('nvim-highlight-colors').setup({
            render = "background";
          })
        '';
        keymaps = [
          { mode = [ "n" ]; key = "<leader>vc"; action = "<cmd>HighlightColors Toggle<CR>"; options = { noremap = true; silent = true; desc = "Toggle Highlight Colors"; }; }
        ];
      };
    }
  ]);
}
