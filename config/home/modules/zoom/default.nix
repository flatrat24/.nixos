{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    zoom-us
  ];
in {
  imports = [ ];

  options = {
    zoom = {
      enable = lib.mkEnableOption "enables zoom";
    };
  };

  config = lib.mkIf config.zoom.enable {
    home.packages = dependencies;
  };
}
