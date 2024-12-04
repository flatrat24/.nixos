{ pkgs, lib, inputs, config, ... }: {
  options = {};

  config = lib.mkIf config.hypr.enable {
    wayland.windowManager.hyprland.settings = {
      bindd = [
        ##### Launch Applications #####
        "$mod, Escape, Lock Screen, exec, hyprlock"
        "$mod, A, Launch Terminal, exec, $terminal"
        "$mod, S, Launch Browser, exec, $browser"
      ];
    };
  };
}
