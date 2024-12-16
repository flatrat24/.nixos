{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    teams-for-linux
  ];
in {
  imports = [ ];

  options = {
    teams = {
      enable = lib.mkEnableOption "enables teams";
    };
  };

  config = lib.mkIf config.teams.enable {
    home.packages = dependencies;
  };
}
