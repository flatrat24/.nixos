{ config, lib, pkgs, ... }:

{
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
