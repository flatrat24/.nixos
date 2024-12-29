{ pkgs, lib, config, ... }:
let
  cfg = config.teams;
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

  config = lib.mkIf cfg.enable {
    home.packages = dependencies;
  };
}
