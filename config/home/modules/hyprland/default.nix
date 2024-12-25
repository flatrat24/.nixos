{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    hyprland
    hyprshot
    hyprlang
    hypridle
    hyprpicker
    hyprshade
    libnotify
    rofi-wayland
    pamixer
    brightnessctl
    wev
  ];
in {
  imports = [
    ./autostart/default.nix
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
      dunst.enable = lib.mkDefault true;
      waybar.enable = lib.mkDefault true;
      waycorner.enable = lib.mkDefault true;
      wlogout.enable = lib.mkDefault true;

      home.packages = dependencies;

      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          "$mod" = "SUPER";
          "$terminal" = "foot";
        };
        plugins = [
          # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprexpo
        ];
      };
    }
    (lib.mkIf config.theme.enable {
      stylix.targets = {
        hyprland.enable = true;
      };
    })
  ]);
}
