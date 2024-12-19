{ pkgs, lib, config, ... }: {
  options = {
    neovim.plugins.dashboard = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.dashboard.enable (lib.mkMerge [
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
                  action = "cd $CURRENTCOURSE | Yazi";
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
      };
    }
  ]);
}
