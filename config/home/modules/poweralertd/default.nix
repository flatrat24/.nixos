{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    poweralertd
  ];
in {
  imports = [ ];

  options = {
    poweralertd = {
      enable = lib.mkEnableOption "enables poweralertd";
    };
  };

  config = lib.mkIf config.poweralertd.enable {
    home.packages = dependencies;
  };
}
