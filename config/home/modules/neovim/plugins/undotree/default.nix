{ lib, config, ... }: {
  options = {
    neovim.plugins.undotree = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.undotree.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.undotree = {
          enable = true;
        };
        keymaps = [
          { mode = [ "n" ]; key = "<leader>vu"; action = "<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>"; options = { noremap = true; silent = true; desc = "Toggle Undotree View"; }; }
        ];
      };
    }
  ]);
}
