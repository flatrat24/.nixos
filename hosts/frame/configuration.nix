{ config, pkgs, ... }:

{
  networking.hostName = "leoito";

  imports = [
    ./hardware-configuration.nix
    ../../config/system/default.nix
  ];

  basicPackages.enable  = true;
  basicSettings.enable  = true;
  bluetooth.enable      = true;
  grub.enable           = true;
  hyprland.enable       = true;
  network.enable        = true;
  nvidia.enable         = false;
  pipewire.enable       = true;
  power.enable          = false;
  printing.enable       = false;
  sddm.enable           = false;
  stylix.enable         = true;
  syncthing.enable      = true;
  system76.enable       = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  users.users.ea = {
    isNormalUser = true;
    description = "Ethan Anthony";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };

  programs.hyprland.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}
