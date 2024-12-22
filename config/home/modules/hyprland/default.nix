{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    hyprland
    hyprshot
    hyprlang
    hypridle
    hyprpicker
    grimblast
    libnotify
    rofi-wayland
    pamixer
    brightnessctl
    wev
  ];
in {
  imports = [
    ./autostart/default.nix
    ./hyprlock/default.nix
    ./hyprpaper/default.nix
    ./input/default.nix
    ./keybinds/default.nix
    ./monitors/default.nix
    ./theme/default.nix
    ./windowRules/default.nix
  ];

  options = {
    hyprland.enable = lib.mkEnableOption "enables hypr";
  };

  config = lib.mkIf config.hyprland.enable (lib.mkMerge [
    {
      home.packages = dependencies;

      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          "$mod" = "SUPER";
          "$terminal" = "foot";
        };
      };
    }
    (lib.mkIf config.theme.enable {
      stylix.targets = {
        hyprland.enable = true;
      };
    })
  ]);
}
