{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.hardware;
in {
  imports = [ ];

  options = {
    hardware = {
      monitor = lib.mkOption {
        type = lib.types.str;
        default = "framework";
      };
      keyboard = lib.mkOption {
        type = lib.types.str;
        default = "framework";
      };
      touchpad.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };

  config = lib.mkMerge [
    {
      wayland.windowManager.hyprland.settings = {
        input = {
          "touchpad" = {
            "disable_while_typing" = "true";
            "drag_lock" = "true";
            "tap-and-drag" = "true";
            "natural_scroll" = "true";
          };
        };
        gestures = {
          "workspace_swipe" = "true";
          "workspace_swipe_fingers" = "3";
        };
      };
    }
  ];
}
