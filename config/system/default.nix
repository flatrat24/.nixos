{ pkgs, lib, config, ... }: {
  imports = [
    ./modules/basicPackages.nix
    ./modules/basicSettings.nix
    ./modules/bluetooth.nix
    ./modules/gaming.nix
    ./modules/grub.nix
    ./modules/hyprland.nix
    ./modules/network.nix
    ./modules/nvidia.nix
    ./modules/pipewire.nix
    ./modules/power.nix
    ./modules/printing.nix
    ./modules/sddm.nix
    ./modules/stylix.nix
    ./modules/syncthing.nix
    ./modules/system76.nix
  ];
}
