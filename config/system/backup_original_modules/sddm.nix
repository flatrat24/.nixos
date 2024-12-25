{ pkgs, lib, config, ... }:
let
  tokyo-night-sddm = pkgs.libsForQt5.callPackage ../../../pkgs/tokyo-night-sddm/default.nix { };
  sddm-astronaut-theme = pkgs.libsForQt5.callPackage ../../../pkgs/sddm-astronaut-theme/default.nix { };
in {
  options = {
    sddm.enable = lib.mkEnableOption "enables sddm";
  };

  config = lib.mkIf config.sddm.enable {
    environment.defaultPackages = with pkgs; [
      tokyo-night-sddm
      sddm-astronaut
    ];

    services.displayManager.sddm = {
      enable = true;
      # defaultSession = "hyprland";
      wayland.enable = true;
      enableHidpi = true;
      theme = "tokyo-night-sddm";
      settings = {
        General = {
          GreeterEnvironment = "QT_SCREEN_SCALE_FACTORS=2,QT_FONT_DPI=192";
        };
      };
    };
  };
}
