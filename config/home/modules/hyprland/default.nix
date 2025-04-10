{ pkgs, inputs, split-monitor-workspaces, lib, config, ... }:
let
  cfg = config.hyprland;
  aliases = {
    "copy" = "wl-copy";
  };
  dependencies = with pkgs; [
    hyprland
    hyprshot
    hyprlang
    hypridle
    hyprpicker
    hyprshade
    libnotify
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

      programs.bash.shellAliases = aliases;
      programs.zsh.shellAliases = aliases;

      home.packages = dependencies;

      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          "monitor" = [
            ", preferred, auto-right, 1" "Unknown-1, disable" # Disables (nvidia) ghost monitor
            "eDP-1, 2880x1920@120.00Hz, 0x0, 2"
            "DP-4, 1920x1080@60.00Hz, 0x0, 1"
          ];
          "$mod" = "SUPER";
          misc = {
            "focus_on_activate" = "true";
          };
          windowrulev2 = [
            "suppressevent maximize, class:.*"
            "center, floating:1"
          ];
          # bindd = [
          #   "$mod, grave, Workspace Overview, hyprexpo:expo, toggle"
          # ];
          plugin = {
            hyprsplit = {
              "num_workspaces" = 10;
            };
            # hyprexpo = {
            #   "columns" = "3";
            #   "gap_size" = "5";
            #   "bg_col" = "rgb(1E1E2E)";
            #   "workspace_method" = "center current"; # [center/first] [workspace] e.g. first 1 or center m+1
            #
            #   "enable_gesture" = "true"; # laptop touchpad
            #   "gesture_fingers" = "4";  # 3 or 4
            #   "gesture_distance" = "300"; # how far is the "max"
            #   "gesture_positive" = "true"; # positive = swipe down. Negative = swipe up.
            # };
          };
        };
        plugins = [
          # inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
          pkgs.hyprlandPlugins.hyprsplit
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
