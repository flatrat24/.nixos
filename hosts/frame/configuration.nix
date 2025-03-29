{ pkgs, ... }: {
  networking.hostName = "leoito";

  imports = [
    ./hardware-configuration.nix
    ../../config/system/default.nix
  ];

  basics.enable       = true;
  bluetooth.enable    = true;
  gaming.enable       = false;
  gnome.enable        = true;
  grub.enable         = false;
  hyprland.enable     = true;
  network.enable      = true;
  nvidia.enable       = false;
  pipewire.enable     = true;
  power.enable        = true;
  printing.enable     = false;
  qmk.enable          = true;
  sddm.enable         = true;
  syncthing.enable    = true;
  system76.enable     = false;
  systemd-boot.enable = true;
  theme.enable        = true;
  vm.enable           = true;

  users.users.ea = {
    isNormalUser = true;
    description = "Ethan Anthony";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
