{ pkgs, lib, config, ... }:
let
  cfg = config.neovim.plugins.dashboard;
in {
  options = {
    neovim.plugins.dashboard = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.nixvim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.dashboard = {
          enable = true;
          settings = {
            hide = {
              tabline = true;
            };
            theme = "doom";
            config = {
              header = [
                "                                   "
                "                                   "
                "                                   "
                "                                   "
                "                                   "
                "                                   "
                "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          "
                "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       "
                "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     "
                "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    "
                "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   "
                "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  "
                "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   "
                " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  "
                " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ "
                "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     "
                "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     "
                "                                   "
                "                                   "
              ];
              center = [
                {
                  icon = "󰥨  ";
                  desc = "Explore Filesystem";
                  key = "d";
                  action = "Yazi";
                }
                {
                  icon = "󰥨  ";
                  desc = "Find File";
                  key = "f";
                  action = "Telescope find_files";
                }
                {
                  icon = "󰱼  ";
                  desc = "Live Grep";
                  key = "g";
                  action = "Telescope live_grep";
                }
                {
                  icon = "  ";
                  desc = "School";
                  key = "s";
                  action = "cd $HOME/Documents/School | Yazi";
                }
                {
                  icon = "󱄅  ";
                  desc = "NixOS Config";
                  key = "x";
                  action = "cd $HOME/.nixos | Yazi";
                }
                {
                  icon = "󰌆  ";
                  desc = "Password Store";
                  key = "p";
                  action = "cd $HOME/.password-store | Yazi";
                }
                {
                  icon = "󰈆  ";
                  desc = "Quit";
                  key = "q";
                  action = "q";
                }
              ];
              footer = [
                "                                     "
                "If it's meant to be, then it will be."
              ];
            };
          };
        };
        keymaps = [
          { mode = [ "n" ]; key = "<leader>`"; action = "<cmd>Dashboard<CR>"; options = { noremap = true; silent = true; desc = "Return to Dashboard"; }; }
        ];
      };
    }
  ]);
}
