{ pkgs, lib, config, ... }:
let
  cfg = config.hyprland;
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
    grim
    slurp
  ];
in {
  imports = [
    ./autostart
    ./input
    ./keybinds
    ./theme
  ];

  options = {
    hyprland.enable = lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
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
          windowrulev2 = [
            "suppressevent maximize, class:.*"
          ];
        };
        plugins = [
          # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprexpo
        ];
        extraConfig = ''
          exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        '';
      };
    }
  ]);
}
