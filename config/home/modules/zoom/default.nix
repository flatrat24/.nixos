{ pkgs, lib, config, ... }:
let
  cfg = config.zoom;
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

  config = lib.mkIf cfg.enable {
    home.packages = dependencies;
  };
}
