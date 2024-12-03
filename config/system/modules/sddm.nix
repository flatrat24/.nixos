{ pkgs, lib, config, ... }: {
  options = {
    sddm.enable = lib.mkEnableOption "enables sddm";
  };

  config = lib.mkIf config.sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      # defaultSession = "hyprland";
      wayland.enable = true;
    };
  };
}
