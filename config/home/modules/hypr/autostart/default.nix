# TODO: Make modular with which applications to launch

{ pkgs, lib, inputs, config, ... }:
let
  dependencies = with pkgs; [
    wl-clip-persist
    wl-clipboard
  ];
in {
  options = { };

  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      settings = {
        "exec-once" = [
          "mako"
          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"
          "wl-clip-persist --clipboard regular"

          "[workspace 1 silent] foot -e ncmpcpp"
          "[workspace 2 silent] firefox"
          "[workspace 9 silent] beeper"
          "[workspace 10 silent] thunderbird"
        ];
      };
    };
  };
}
