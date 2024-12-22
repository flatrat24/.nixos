{ pkgs, lib, inputs, config, ... }: {
  options = {
    input.keyboard = {
      formFactor = lib.mkOption {
        type = lib.types.str;
        default = "ANSI"; # options: "mac", "ANSI"
      };
    };
  };

  config = lib.mkIf config.hyprland.enable (lib.mkMerge [
    (lib.mkIf (config.input.keyboard.formFactor == "mac") {
      wayland.windowManager.hyprland.settings = {
        bindd = [
          ##### Notifications #####
          ", XF86LaunchA, Restore Last Notification, exec, makoctl restore"
          ", XF86LaunchB, Dismiss Last Notification, exec, makoctl dismiss"

          ##### Color Picker #####
          ", XF86KbdBrightnessDown, Activate Color Picker, exec, hyprpicker | wl-copy"
        ];
        binded = [
          ##### Screenshots #####
          ", XF86KbdBrightnessUp, Screenshot (Select Area), exec, grimblast --notify copysave area"
          "$mod SHIFT, XF86KbdBrightnessUp, Screenshot (Entire Screen), exec, grimblast --notify copysave screen"
        ];
        bindeld = [
          ##### Volume Controls #####
          ", XF86AudioMute, Toggle Volume Mute, exec, pamixer -t"
          ", XF86AudioRaiseVolume, Increase Volume, exec, pamixer -i 2"
          ", XF86AudioLowerVolume, Decrease Volume, exec, pamixer -d 2"

          ##### Unbound Keys #####
          # ", F4, Toggle Volume Mute, exec, pamixer -t"
          # ", F5, Increase Volume, exec, pamixer -i 2"
          # ", F6, Decrease Volume, exec, pamixer -d 2"

          ##### Brightness #####
          ", XF86MonBrightnessDown, Decrease Screen Brightness, exec, brightnessctl s 2%-"
          ", XF86MonBrightnessUp, Increase Screen Brightness, exec, brightnessctl s +2%"

          ##### Screenshots #####
          "$mod, XF86KbdBrightnessUp, Screenshot (Focused Window), exec, grimblast --notify copysave active"
        ];
        bindld = [
          ##### MPD Controls #####
          ", XF86AudioNext, Play Next Song (MPD), exec, mpc prev"
          ", XF86AudioPlay, Play/Pause Song (MPD), exec, mpc toggle"
          ", XF86AudioPrev, Play Previous Song (MPD), exec, mpc next"
        ];
      };
    })

    (lib.mkIf (config.input.keyboard.formFactor == "ANSI") {
      wayland.windowManager.hyprland.settings = {
        bindd = [
          ##### Color Picker #####
          ", F12, Activate Color Picker, exec, hyprpicker | wl-copy"
        ];
        binded = [
          ##### Screenshots #####
          ", F11, Screenshot (Select Area), exec, grimblast --notify copysave area"
          "$mod SHIFT, F11, Screenshot (Entire Screen), exec, grimblast --notify copysave screen"
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
          "$mod, F11, Screenshot (Focused Window), exec, grimblast --notify copysave active"
        ];
        bindld = [
          ##### MPD Controls #####
          ", XF86AudioRaiseVolume, Play Next Song (MPD), exec, mpc prev"
          ", XF86AudioLowerVolume, Play/Pause Song (MPD), exec, mpc toggle"
          ", XF86AudioMute, Play Previous Song (MPD), exec, mpc next"
        ];
      };
    })
  ]);
}
