{ inputs, pkgs, ... }: {
  wayland.windowManager.hyprland.settings = {
    bindd = [
      ##### Launch Applications #####
      "$mod, Escape, Lock Screen, exec, hyprlock"
      "$mod, A, Launch Terminal, exec, $terminal"
      "$mod, D, Launch Browser, exec, $browser"
    ];
  };
}
