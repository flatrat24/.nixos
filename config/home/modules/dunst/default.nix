{ pkgs, lib, inputs, config, ... }:
let
  dependencies = with pkgs; [
    dunst
  ];
in {
  options = {
    dunst = {
      enable = lib.mkEnableOption "enable dunst";
    };
  };

  config = lib.mkIf config.dunst.enable (lib.mkMerge [
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
        (lib.mkIf (config.input.keyboard.formFactor == "mac") {
          bindd = [
            # ", XF86LaunchA, Restore Last Notification, exec, dunstctl restore" <- doesn't exist
            ", XF86LaunchB, Dismiss Last Notification, exec, dunstctl close"
          ];
        })
        (lib.mkIf (config.input.keyboard.formFactor == "ANSI") {
          bindd = [
            # ", F9, Restore Last Notification, exec, dunstctl restore" <- doesn't exist
            ", F10, Dismiss Last Notification, exec, dunstctl close"
          ];
        })
      ]);
    })
  ]);
}
