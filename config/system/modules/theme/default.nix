{ pkgs, lib, config, inputs, ... }:
let
  sddm-astronaut = (pkgs.sddm-astronaut.override {
    themeConfig = {
      # [General]
      CustomBackground = true;
      Background = config.stylix.image;
      DimBackgroundImage = "0.0";
      ScreenWidth="2880";
      ScreenHeight="1920";
      ScreenPadding="0";

      # [Blur Settings]
      FullBlur = false;
      PartialBlur = true;
      BlurRadius = 80;

      # [Design Customizations]
      ## Form Customizations
      HaveFormBackground = true;
      FormPosition = "left";

      Font = config.stylix.fonts.monospace.name;
      FontSize = config.stylix.fonts.sizes.applications;

      ## Colors
      MainColor = config.lib.stylix.colors.withHashtag.base05;
      AccentColor = config.lib.stylix.colors.withHashtag.base0F;

      # Change password placeholder colors
      placeholderColor = config.lib.stylix.colors.withHashtag.base0F;
      IconColor = config.lib.stylix.colors.withHashtag.base05;

      # Make form use a darker color
      BackgroundColor = config.lib.stylix.colors.withHashtag.base00;

      # [Locale]
      HourFormat = "\"HH:mm\"";
      DateFormat = "\"MMMM d, yyyy\"";
    };
  });
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
