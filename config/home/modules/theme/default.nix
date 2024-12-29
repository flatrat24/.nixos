# TODO: Embed this file in each respective program's module or make this theme.nix and
#       have it include gtk, qt, etc. themeing as well and make all other programs use
#       program.enable in their modules

{ pkgs, lib, config, ... }: {
  options = {
    theme.enable = lib.mkEnableOption "enables theme";
  };

  config = lib.mkIf config.theme.enable {
    fonts.fontconfig.enable = true;

    stylix = {
      enable = lib.mkDefault true;
      autoEnable = false;
      image = ../../../assets/mountains.png;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

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

    # home.pointerCursor.hyprcursor = {
    #   enable = true;
    #   size = 24;
    # };
    wayland.windowManager.hyprland.settings = {
      "exec-once" = [
        "hyprctl setcursor size 24"
      ];
    };
  };
}
