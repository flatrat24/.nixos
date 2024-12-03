{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    hyprland
    hyprshot
    hyprlang
    hypridle
    hyprpicker
    xdg-desktop-portal-hyprland
    cliphist
    wl-clipboard
    wl-clip-persist
    grimblast
    mako
    libnotify
    rofi-wayland
    pamixer
    brightnessctl
    wev
    foot
  ];
in {
  imports = [
    ./keybinds/default.nix
    ./theme.nix
    ./input.nix
    ./monitors/default.nix
    ./windowRules.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  options = {
    hypr.enable = lib.mkEnableOption "enables hypr";
  };

  config = lib.mkIf config.hypr.enable {
    home.packages = dependencies;

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        "$terminal" = "foot";
      };
    };

    home.sessionVariables = {
      BOOKMARKS = "/home/ea/Documents/Personal/bookmarks.json";
    };
  };
}
