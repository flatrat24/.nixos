{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.better-control;
  dependencies = [
    inputs.better-control.packages.${pkgs.system}.better-control
  ];
in {
  options = {
    better-control.enable = lib.mkEnableOption "enable better-control";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
  ]);
}
