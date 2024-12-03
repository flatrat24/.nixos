{ pkgs, lib, config, ... }: { # TODO: remake module completely
  options = {
    hyprland.enable = lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
    };
  };

  config = lib.mkIf config.nvidia.enable {
    programs.hyprland = {
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
        nvidiaSettings = true;
      };
    };

    environment.systemPackages = with pkgs; [ ];
  };
}
