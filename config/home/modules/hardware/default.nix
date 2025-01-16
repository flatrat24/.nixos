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
        "monitor" = [ ", preferred, auto-right, 1" "Unknown-1, disable" ] # Disables (nvidia) ghost monitor
          ++ lib.optionals (cfg.monitor == "framework") [ "eDP-1, 2880x1920@120.00Hz, 0x0, 2" "DP-1, 1920x1080@165.00Hz, 0x0, 1" ]; # TODO: Split monitors into two and create another option to set to MSI monitor
        bindd = [ # lib.optionals (cfg.keyboard == "framework")
          ##### Color Picker #####
          ", F12, Activate Color Picker, exec, hyprpicker | wl-copy"
        ];
        binded = [
          ##### Screenshots #####
          '', F11, Screenshot (Select Area), exec, hyprshot --mode region --output-folder ~/Downloads''
          ''$mod SHIFT, F11, Screenshot (Entire Screen), exec,  hyprshot --mode output --mode active --output-folder ~/Downloads''
        ];
        bindeld = [
          ##### Volume Controls #####
          ", F1, Toggle Volume Mute, exec, pamixer -t"
          ", F2, Decrease Volume, exec, pamixer -d 2"
          ", F3, Increase Volume, exec, pamixer -i 2"

          ##### Unbound Keys #####
          # ", F4, Toggle Volume Mute, exec, pamixer -t"
          # ", F5, Increase Volume, exec, pamixer -i 2"
          # ", F6, Decrease Volume, exec, pamixer -d 2"

          ##### Brightness #####
          ", F7, Decrease Screen Brightness, exec, brightnessctl s 2%-"
          ", F8, Increase Screen Brightness, exec, brightnessctl s +2%"

          ##### Screenshots #####
          ''$mod, F11, Screenshot (Focused Window), exec,  hyprshot --mode window --output-folder ~/Downloads''
        ];
        bindld = [
          ##### MPD Controls #####
          ", XF86AudioRaiseVolume, Play Next Song (MPD), exec, mpc next"
          ", XF86AudioLowerVolume, Play/Pause Song (MPD), exec, mpc toggle"
          ", XF86AudioMute, Play Previous Song (MPD), exec, mpc prev"
        ];
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
