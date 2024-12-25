# TODO: Make modular with which applications to launch

{ pkgs, lib, inputs, config, ... }:
let
  dependencies = with pkgs; [
    wl-clip-persist
    wl-clipboard
    cliphist
  ];
in {
  options = { };

  config = lib.mkIf config.hyprland.enable {
    home.packages = dependencies;

    wayland.windowManager.hyprland = {
      settings = {
        "exec-once" = [
          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"
          "wl-clip-persist --clipboard regular"

          "hyprctl setcursor size 24"

          "[workspace 1 silent] foot -e ncmpcpp"
          "[workspace 2 silent] firefox"
          "[workspace 9 silent] beeper"
          "[workspace 10 silent] thunderbird"
        ];
      };
    };
  };
}
