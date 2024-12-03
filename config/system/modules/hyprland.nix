{ pkgs, lib, config, ... }: { # TODO: remake module completely
  options = {
    hyprland.enable = lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland.enable = true;
    programs.hyprland.xwayland.enable = true;

    environment.sessionVariables = lib.mkIf config.nvidia.enable {
      WLR_NOHARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    # services.xserver.videoDrivers = [ "nvidia" ];

    hardware = lib.mkIf config.nvidia.enable {
      opengl.enable = true;
      nvidia = {
        modesetting.enable = true;
        # powerManagement.enable = false;
        # powerManagement.finegrained = false;
        # open = false;
        nvidiaSettings = true;
      };
    };

    environment.systemPackages = with pkgs; [ ];
  };
}
