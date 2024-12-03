{ inputs, pkgs, ... }: {
  imports = [
    ./windowManagement.nix
    ./functionRow.nix
    ./launchApplications.nix
  ];

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "foot";
    "$browser" = "firefox";
  };
}
