{ inputs, pkgs, ... }: {
  wayland.windowManager.hyprland.settings = {
    bindeld = [
      ##### Volume Controls #####
      ", F1, Toggle Volume Mute, exec, pamixer -t"
      ", F2, Increase Volume, exec, pamixer -i 2"
      ", F3, Decrease Volume, exec, pamixer -d 2"

      # ", F4, Toggle Volume Mute, exec, pamixer -t"
      # ", F5, Increase Volume, exec, pamixer -i 2"
      # ", F6, Decrease Volume, exec, pamixer -d 2"

      ", F7, Increase Screen Brightness, exec, brightnessctl s +2%"
      ", F8, Decrease Screen Brightness, exec, brightnessctl s 2%-"

      ", F11, Screenshot (Select Area), exec, grimblast --notify copysave area"
      "$mod, F11, Screenshot (Focused Window), exec, grimblast --notify copysave active"
      "$mod SHIFT, F11, Screenshot (Entire Screen), exec, grimblast --notify copysave screen"

      # ", F9, Increase Volume, exec, pamixer -i 2"
      # ", F10, Decrease Volume, exec, pamixer -d 2"
      # ", F11, Increase Volume, exec, pamixer -i 2"
      # ", F12, Decrease Volume, exec, pamixer -d 2"
    ];
    bindld = [
      ##### MPD Controls #####
      ", XF86AudioRaiseVolume, Play Next Song (MPD), exec, mpc prev"
      ", XF86AudioLowerVolume, Play/Pause Song (MPD), exec, mpc toggle"
      ", XF86AudioMute, Play Previous Song (MPD), exec, mpc next"
    ];
  };
}
