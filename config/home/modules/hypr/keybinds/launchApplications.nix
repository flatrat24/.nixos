{ pkgs, lib, inputs, config, ... }: {
  options = {};

  config = lib.mkIf config.hypr.enable (lib.mkMerge [
    {
      wayland.windowManager.hyprland.settings = {
        bindd = [
          "$mod, Escape, Lock Screen, exec, hyprlock"
          "$mod, A, Launch Terminal, exec, $terminal"
          "$mod, S, Launch Browser, exec, $browser"
        ];
      };
    }
  ]);
}
