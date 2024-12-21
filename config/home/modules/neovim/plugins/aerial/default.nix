{ lib, config, ... }: {
  options = {
    neovim.plugins.aerial = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.aerial.enable {
    programs.nixvim = {
      plugins.aerial = {
        enable = true;
      };
      keymaps = [
        { mode = [ "n" ]; key = "<leader>vo"; action = "<cmd>AerialToggle<CR>"; options = { noremap = true; silent = true; desc = "View Code Outline"; }; }
      ];
    };
  };
}
