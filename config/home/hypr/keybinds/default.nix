{ inputs, pkgs, ... }: {
  imports = [
    ./windowManagement.nix
    ./functionRow.nix
  ];

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "foot";
  };
}
