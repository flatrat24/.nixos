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
          misc = {
            "focus_on_activate" = "true";
          };
          windowrulev2 = [
            "suppressevent maximize, class:.*"
          ];
          # bindd = [
          #   "$mod, grave, Workspace Overview, hyprexpo:expo, toggle"
          # ];
          # plugin = {
          #   hyprexpo = {
          #     "columns" = "3";
          #     "gap_size" = "5";
          #     "bg_col" = "rgb(1E1E2E)";
          #     "workspace_method" = "center current"; # [center/first] [workspace] e.g. first 1 or center m+1
          #
          #     "enable_gesture" = "true"; # laptop touchpad
          #     "gesture_fingers" = "4";  # 3 or 4
          #     "gesture_distance" = "300"; # how far is the "max"
          #     "gesture_positive" = "true"; # positive = swipe down. Negative = swipe up.
          #   };
          # };
        };
        plugins = [
          # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.borders-plus-plus
          # pkgs.hyprlandPlugins.borders-plus-plus
          # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprexpo
          # pkgs.hyprlandPlugins.hyprexpo
          # inputs.hyprscroller.packages.${pkgs.stdenv.hostPlatform.system}.hyprscroller
          # pkgs.hyprlandPlugins.hyprscroller
        ];
        extraConfig = ''
          exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        '';
      };
    }
  ]);
}
