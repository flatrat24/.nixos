{ pkgs, lib, config, ... }: {
  # options = {
  #   stylix.enable = lib.mkEnableOption "enables stylix";
  # };

  config = lib.mkIf config.stylix.enable {
    fonts.fontDir.enable = true;

    stylix = {
      autoEnable = false;
      image = ../home/sources/hypr/assets/grove.png;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
      homeManagerIntegration = {
        autoImport = true;
        followSystem = true;
      };

      targets = {
        console.enable = true;
        grub.enable = false;
        gtk.enable = true;
        nixos-icons.enable = true;
      };

      cursor = {
        name = "macOS-BigSur";
        package = pkgs.apple-cursor;
        size = 24;
      };
      fonts = {
        # packages = with pkgs; [
        #   (pkgs.nerdfonts.override {
        #     fonts = [
        #       "IBMPlexMono"
        #       "Iosevka"
        #       "IosevkaTerm"
        #     ];
        #   })
        # ];
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
  };
}
