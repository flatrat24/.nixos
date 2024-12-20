{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [ ripgrep ];
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
          extensions = {
            fzf-native = { enable = true; };
          };
          settings = {
            defaults = {
              mappings = {
                i = {
                  "<C-k>" = {
                    __raw = "require('telescope.actions').move_selection_previous";
                  };
                  "<C-j>" = {
                    __raw = "require('telescope.actions').move_selection_next";
                  };
                  "<C-q>" = {
                    __raw = "require('telescope.actions').close";
                  };
                  "<CR>"  = {
                    __raw = "require('telescope.actions').select_default";
                  };
                  "<C-m>" = {
                    __raw = "require('telescope.actions').select_vertical";
                  };
                  "<C-n>" = {
                    __raw = "require('telescope.actions').select_horizontal";
                  };
                  "<C-t>" = {
                    __raw = "require('telescope.actions').select_tab";
                  };
                };
              };
            };
          };
        };
        keymaps = [
          { mode = [ "n" ]; key = "<leader>ff"; action = "<cmd>Telescope find_files<CR>"; options = { noremap = true; silent = true; desc = "Find files"; }; }
          { mode = [ "n" ]; key = "<leader>fg"; action = "<cmd>Telescope live_grep<CR>"; options = { noremap = true; silent = true; desc = "Live grep"; }; }
          { mode = [ "n" ]; key = "<leader>fb"; action = "<cmd>Telescope buffers<CR>"; options = { noremap = true; silent = true; desc = "Buffers"; }; }
          { mode = [ "n" ]; key = "<leader>c"; action = "<cmd>Telescope command_history<CR>"; options = { noremap = true; silent = true; desc = "Command history"; }; }
          { mode = [ "n" ]; key = "<leader>h"; action = "<cmd>Telescope help_tags<CR>"; options = { noremap = true; silent = true; desc = "Help"; }; }
        ];
      };
    }
  ]);
}
