{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    lshw
  ];
  hyprlandDependencies = with pkgs; [
    egl-wayland
    wayland-utils
    kdePackages.wayland-protocols
  ];
in {
  options = {
    nvidia.enable = lib.mkEnableOption "enables nvidia";
  };

  config = lib.mkIf config.nvidia.enable {
    services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };

    hardware = {
      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        powerManagement = {
          enable = false;
          finegrained = false;
        };
        open = true;
        nvidiaSettings = true;
        modesetting.enable = lib.mkDefault true;
      };
    };
  
    environment.systemPackages = dependencies ++
      (if (config.hyprland.enable == true) then
        hyprlandDependencies
      else
        []
      );
  };
}
