{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    zellij
  ];
in {
  options = {
    zellij.enable = lib.mkEnableOption "enables zellij";
  };

  config = lib.mkIf config.zellij.enable {
    home.packages = dependencies;

    home.file = {
      ".config/zellij" = {
        source = ./sources;
        executable = false;
        recursive = true;
      };
    };
  };
}
