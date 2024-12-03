{ inputs, pkgs, ... }: {
  wayland.windowManager.hyprland.settings = {
    bindd = [
      ##### Notifications #####
      ", F9, Restore Last Notification, exec, makoctl restore"
      ", F10, Dismiss Last Notification, exec, makoctl dismiss"

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
      ", F2, Increase Volume, exec, pamixer -i 2"
      ", F3, Decrease Volume, exec, pamixer -d 2"

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
}
