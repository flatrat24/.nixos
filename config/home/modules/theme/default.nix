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
      enable = true;
      autoEnable = false;
      image = ../hypr/sources/assets/grove.png;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

      targets = {
        gtk.enable = true;
      };

      # iconTheme = {
      #   enable = true;
      #   package = pkgs.papirus-icon-theme;
      # };
      opacity = {
        applications = 0.9;
        desktop = 0.9;
        popups = 0.9;
        terminal = 0.9;
      };
    };
  };
}
