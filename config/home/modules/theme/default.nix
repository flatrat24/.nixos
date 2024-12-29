{ pkgs, lib, config, ... }:
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

  config = lib.mkIf cfg.enable {
    home.file = {
      ".assets" = {
        source = ../../../assets;
        executable = false;
        recursive = true;
      };
    };

    fonts.fontconfig.enable = true;

    stylix = {
      enable = lib.mkDefault true;
      autoEnable = false;
      image = ../../../assets/${cfg.wallpaper};
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.colorscheme}.yaml";

      targets = {
        gtk.enable = true;
      };

      iconTheme = {
        enable = true;
        package = pkgs.catppuccin-papirus-folders;
        light = "Papirus-Light";
        dark = "Papirus-Dark";
      };
    };

    wayland.windowManager.hyprland.settings = {
      "exec-once" = [
        "hyprctl setcursor size 24"
      ];
    };
  };
}
