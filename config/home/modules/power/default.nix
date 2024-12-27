{ pkgs, lib, config, ... }:
let
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
        default = config.power.enable;
      };
    };
  };

  config = lib.mkIf config.power.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
    (lib.mkIf config.power.alerts.enable {
      home.packages = [ pkgs.upower-notify ];
    })
  ]);
}
