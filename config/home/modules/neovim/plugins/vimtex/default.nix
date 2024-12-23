{ lib, config, ... }: {
  options = {
    neovim.plugins.vimtex = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.neovim.enable && config.latex.enable);
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.vimtex.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.vimtex = {
          enable = true;
          settings = {
            view_method = "zathura";
          };
        };
        # keymaps = [
        #   { mode = [ "n" ]; key = "<leader>vu"; action = "<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>"; options = { noremap = true; silent = true; desc = "Toggle Undotree View"; }; }
        # ];
      };
    }
  ]);
}
