{ pkgs, lib, config, ... }: {
  options = {
    sddm.enable = lib.mkEnableOption "enables sddm";
  };

  config = lib.mkIf config.sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm; # qt6 sddm version
      enableHidpi = true;
    };
  };
}
