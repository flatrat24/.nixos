{ pkgs, lib, config, inputs, ... }:
let
  sddm-astronaut = pkgs.libsForQt5.callPackage ../../../../pkgs/sddm-astronaut-theme { };
in {
  options = {
    theme.enable = lib.mkEnableOption "enables theme";
  };

  config = lib.mkIf config.theme.enable {
    fonts.fontDir.enable = true;

    stylix = {
      enable = lib.mkDefault true;
      autoEnable = false;
      image = "${inputs.wallpapers}/biking_sunset.jpg";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
      homeManagerIntegration = {
        autoImport = true;
        followSystem = true;
      };

      targets = {
        console.enable = true;
        gtk.enable = true;
        nixos-icons.enable = true;
      };

      cursor = {
        name = "catppuccin-frappe-dark-cursors";
        package = pkgs.catppuccin-cursors.frappeDark;
        size = 24;
      };

      fonts = {
        serif = {
          name = "IBM Plex Serif";
          package = pkgs.ibm-plex;
        };
        sansSerif = {
          name = "IMB Plex Sans";
          package = pkgs.ibm-plex;
        };
        monospace = {
          name = "IBM Plex Mono";
          package = pkgs.ibm-plex;
        };
        emoji = {
          name = "Twemoji";
          package = pkgs.twitter-color-emoji;
        };
        sizes = {
          applications = 12;
          desktop = 10;
          popups = 10;
          terminal = 12;
        };
      };
    };
    
    environment.defaultPackages = [
      sddm-astronaut
    ];

    services.displayManager.sddm = {
      theme = "sddm-astronaut-theme";
      extraPackages = [ sddm-astronaut ];
      settings = {
        General = {
          GreeterEnvironment = lib.mkDefault "QT_SCREEN_SCALE_FACTORS=2,QT_FONT_DPI=192"; # For hidpi # TODO: Make different for different monitors
        };
      };
    };
  };
}
