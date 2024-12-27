{ config, pkgs, ... }: {
  networking.hostName = "leoito";

  imports = [
    ./hardware-configuration.nix
    ../../config/system/default.nix
  ];

  basicPackages.enable  = true;
  basicSettings.enable  = true;
  bluetooth.enable      = true;
  gaming.enable         = true;
  grub.enable           = true;
  hyprland.enable       = true;
  network.enable        = true;
  nvidia.enable         = false;
  pipewire.enable       = true;
  power.enable          = false;
  printing.enable       = false;
  sddm.enable           = true;
  syncthing.enable      = true;
  system76.enable       = false;
  theme.enable          = true;
  vm.enable             = true;

  users.users.ea = {
    isNormalUser = true;
    description = "Ethan Anthony";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
