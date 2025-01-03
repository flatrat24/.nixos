{ pkgs, lib, config, ... }:
let
  cfg = config.dunst;
  dependencies = with pkgs; [
    dunst
  ];
in {
  options = {
    dunst = {
      enable = lib.mkEnableOption "enable dunst";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home = {
        packages = dependencies;

        file = {
          ".config/dunst/dunstrc" = {
            source = ./sources/dunstrc;
            executable = false;
            recursive = false;
          };
        };
      };
    }
    (lib.mkIf config.hyprland.enable {
      wayland.windowManager.hyprland.settings = (lib.mkMerge [
        {
          "exec-once" = [
            "dunst"
          ];
        }
        (lib.mkIf (config.hardware.keyboard == "mac") {
          binded = [
            ", XF86LaunchA, Restore Last Notification, exec, dunstctl history-pop"
            ", XF86LaunchB, Dismiss Last Notification, exec, dunstctl close"
          ];
        })
        (lib.mkIf (config.hardware.keyboard == "framework") {
          binded = [
            ", F9, Restore Last Notification, exec, dunstctl history-pop"
            ", F10, Dismiss Last Notification, exec, dunstctl close"
          ];
        })
      ]);
    })
  ]);
}
