{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    libreoffice
  ];
in {
  imports = [ ];

  options = {
    libreoffice = {
      enable = lib.mkEnableOption "enables libreoffice";
    };
  };

  config = lib.mkIf config.libreoffice.enable {
    home.packages = dependencies;
  };
}
