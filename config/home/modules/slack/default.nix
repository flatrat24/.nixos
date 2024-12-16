{ pkgs, lib, config, ... }:
let
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

  config = lib.mkIf config.slack.enable {
    home.packages = dependencies;
  };
}
