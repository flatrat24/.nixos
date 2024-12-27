{ pkgs, lib, inputs, config, ... }:
let
  dependencies = with pkgs; [
    obs-studio
    obs-cli
  ];
in {
  options = {
    obs.enable = lib.mkEnableOption "enable obs";
  };

  config = lib.mkIf config.obs.enable {
    home.packages = dependencies;
  };
}
