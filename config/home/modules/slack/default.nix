{ pkgs, lib, config, ... }:
let
  cfg = config.slack;
  dependencies = with pkgs; [
    slack
    slack-term
  ];
in {
  imports = [ ];

  options = {
    slack = {
      enable = lib.mkEnableOption "enables slack";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = dependencies;
  };
}
