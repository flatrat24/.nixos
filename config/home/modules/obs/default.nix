{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.obs;
  dependencies = with pkgs; [
    obs-studio
    obs-cli
  ];
in {
  options = {
    obs.enable = lib.mkEnableOption "enable obs";
  };

  config = lib.mkIf cfg.enable {
    home.packages = dependencies;
  };
}
