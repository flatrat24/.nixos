{ inputs, pkgs, ... }:
let
  dependencies = with pkgs; [ ];
in {
  wayland.windowManager.hyprland.settings = {
    "monitor" = [
      "eDP-1, 2880x1920, 0x0, 1"
    ];
  };
}
