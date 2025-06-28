{ pkgs, lib, config, ... }:
let
  cfg = config.aerc;
  dependencies = with pkgs; [
    aerc
  ];
in {
  options = {
    aerc.enable = lib.mkEnableOption "enables aerc";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.file = {
        ".config/aerc" = {
          source = ./sources;
          executable = false;
          recursive = true;
        };
      };

      home.packages = dependencies;
    }
  ]);
}
