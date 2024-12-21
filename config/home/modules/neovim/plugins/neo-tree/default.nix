{ pkgs, lib, config, ... }: {
  options = {
    neovim.plugins.neo-tree = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.neo-tree.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.neo-tree = {
          enable = true;
        };
        keymaps = [
          { mode = [ "n" ]; key = "<leader>ve"; action = "<cmd>Neotree toggle reveal filesystem right<CR>"; options = { noremap = true; silent = true; desc = "View Filesystem Tree"; }; }
          { mode = [ "n" ]; key = "<leader>vb"; action = "<cmd>Neotree toggle reveal buffers right<CR>"; options = { noremap = true; silent = true; desc = "View Buffer Tree"; }; }
        ];
      };
    }
    (lib.mkIf config.neovim.plugins.transparent.enable {
      programs.nixvim.extraConfigLua = ''
        vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE", ctermbg = "NONE" })
      '';
    })
  ]);
}
