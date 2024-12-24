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
          filesystem = {
            filteredItems = {
              visible = true;
            };
          };
          window = {
            mappings = {
              "<2-LeftMouse>" = "open";
              "<cr>" = "set_root";
              l = "open";
              h = "navigate_up";
              "<esc>" = "revert_preview";
              P = {
                command = "toggle_preview";
                config = { use_float = true; };
              };
              n = "open_split";
              m = "open_vsplit";
              t = "open_tabnew";
              w = "open_with_window_picker";
              C = "close_node";
              z = "close_all_nodes";
              R = "refresh";
              y = "copy_to_clipboard";
              x = "cut_to_clipboard";
              p = "paste_from_clipboard";
              e = "toggle_auto_expand_width";
              q = "close_window";
              "?" = "show_help";
              "<" = "prev_source";
              ">" = "next_source";
            };
          };
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
