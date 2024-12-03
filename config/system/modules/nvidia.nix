{ pkgs, lib, config, ... }: { # TODO: remake module completely
  options = {
    nvidia.enable = lib.mkEnableOption "enables nvidia";
  };

  config = lib.mkIf config.nvidia.enable {
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

    services.xserver.videoDrivers = [ "nvidia" ];
  };
}
