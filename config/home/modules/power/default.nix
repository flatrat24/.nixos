{ pkgs, lib, config, ... }:
let
  cfg = config.power;
  dependencies = with pkgs; [
    gnome-power-manager
  ];
in {
  imports = [ ];

  options = {
    power = {
      enable = lib.mkEnableOption "enables power";
      alerts.enable = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
    (lib.mkIf cfg.alerts.enable {
      home.packages = [ pkgs.upower-notify ];
    })
  ]);
}
