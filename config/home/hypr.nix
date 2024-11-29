{ inputs, pkgs, ... }: {

  # home.file = {
  #   ".config/hypr/hyprland.conf" = {
  #     source = ./sources/hypr/hyprland.conf;
  #     executable = false;
  #     recursive = false;
  #   };
  # };

  # home.file = {
  #   ".config/waybar" = {
  #     source = ./sources/waybar;
  #     executable = false;
  #     recursive = true;
  #   };
  # };

  # imports = [ inputs.ags.homeManagerModules.default ];
  # programs.ags = {
  #   enable = true;
  #   extraPackages = with pkgs; [
  #     gtksourceview
  #     webkitgtk
  #     accountsservice
  #   ];
  # };

  # home.file = {
  #   ".config/mako/config" = {
  #     source = ./sources/mako/config;
  #     executable = false;
  #     recursive = false;
  #   };
  # };

  home.packages = with pkgs; [
    hyprland
    hyprshot
    hyprlock
    hyprlang
    hypridle
    hyprpaper
    hyprpicker
    hyprcursor
    # hyprpanel
    xdg-desktop-portal-hyprland
    cliphist
    wl-clipboard
    wl-clip-persist
    grimblast
    # mako
    libnotify
    rofi-wayland
    # waybar
    pamixer
    brightnessctl
    wev
    foot
  ];

  home.sessionVariables = {
    BOOKMARKS = "/home/ea/Documents/Personal/bookmarks.json";
  };

}
