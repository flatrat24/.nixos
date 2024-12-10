{ pkgs, lib, inputs, config, ... }:
let
  dependencies = with pkgs; [ ];
in {
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  options = {
    ags.enable = lib.mkEnableOption "enables ags";
  };

  config = lib.mkIf config.ags.enable {
    home.packages = dependencies;

    programs.ags = {
      enable = true;

      configDir = ./sources;
    };
  };
}
