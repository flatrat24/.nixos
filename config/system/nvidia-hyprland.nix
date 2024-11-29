{ config, lib, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NOHARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  # services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    opengl.enable = true;
    nvidia = {
      modesetting.enable = true;
      # powerManagement.enable = false;
      # powerManagement.finegrained = false;
      # open = false;
      # nvidiaSettings = true;
    };
  };

  environment.systemPackages = with pkgs; [ ];
}
