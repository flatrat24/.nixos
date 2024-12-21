{ lib, config, ... }: {
  options = {
    neovim.plugins.trouble = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.trouble.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.trouble = {
          enable = true;
        };
        keymaps = [
          { mode = [ "n" ]; key = "<leader>vd"; action = "<cmd>Trouble diagnostics<CR>"; options = { noremap = true; silent = true; desc = "View Diagnostics"; }; }
        ];
      };
    }
    (lib.mkIf config.neovim.plugins.todo-comments.enable {
      programs.nixvim.keymaps = [
        { mode = [ "n" ]; key = "<leader>vt"; action = "<cmd>TodoTrouble<CR>"; options = { noremap = true; silent = true; desc = "View Todo Comments"; }; }
      ];
    })
    (lib.mkIf config.neovim.plugins.transparent.enable {
      programs.nixvim.extraConfigLua = ''
        vim.api.nvim_set_hl(0, "TroubleNormal", { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, "TroubleNormalNC", { bg = "NONE", ctermbg = "NONE" })
      '';
    })
  ]);
}
