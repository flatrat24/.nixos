{ inputs, pkgs, ... }: {
  wayland.windowManager.hyprland.settings = {
    bindd = [
      ##### Launch Applications #####
      "$mod, Escape, Lock Screen, exec, hyprlock"
      "$mod, A, Launch Terminal, exec, $terminal"
      "$mod, S, Test, exec, xdg-open ~/nix/home.ni"
      "$mod, D, Launch Terminal, exec, $terminal"
    ];
  };
}
