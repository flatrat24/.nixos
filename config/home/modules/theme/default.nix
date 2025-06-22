{ pkgs, lib, config, inputs, ... }:
let
  cfg = config.theme;
in {
  options = {
    theme = {
      enable = lib.mkEnableOption "enables theme";
      colorscheme = lib.mkOption {
        type = lib.types.str;
        default = "catppuccin-mocha";
      };
      wallpaper = lib.mkOption {
        type = lib.types.str;
        default = "flower_field.jpg";
      };
    };
  };

  imports = [
    # inputs.catppuccin.homeManagerModules.catppuccin
  ];

  config = lib.mkIf cfg.enable {
    home.file = {
      ".assets" = {
        source = ../../../assets;
        executable = false;
        recursive = true;
      };
    };

    qt = {
      enable = true;
      style = {
        package = pkgs.catppuccin-qt5ct;
        name = "qt5ct";
      };
    };

    gtk = {
      enable = true;
      cursorTheme = {
        package = pkgs.catppuccin-cursors.frappeDark;
        name = "catppuccin-frappe-dark-cursors";
        size = 24;
      };
      font = {
        package = "${pkgs.ibm-plex}";
        name = "IBM Plex Sans";
        size = 12;
      };
      iconTheme = {
        package = pkgs.catppuccin-papirus-folders;
        name = "Papirus-Dark";
      };
      # catppuccin = {
      #   enable = true;
      #   flavor = "mocha";
      #   accent = "pink";
      #   size = "standard";
      #   tweaks = [ "normal" ];
      # };
    };

    fonts.fontconfig.enable = true;

    wayland.windowManager.hyprland.settings = {
      "exec-once" = [
        "hyprctl setcursor size 24"
      ];
    };
  };
}
