{ pkgs, lib, config, ... }:
let
  cfg = config.vdirsyncer;
  dependencies = with pkgs; [
    vdirsyncer
  ];
in {
  options = {
    vdirsyncer.enable = lib.mkEnableOption "enables vdirsyncer";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      services.vdirsyncer = {
        enable = true;
        package = pkgs.vdirsyncer;
        frequency = "15min";
      };

      programs.vdirsyncer = {
        enable = true;
        package = pkgs.vdirsyncer;
        statusPath = "~/.vdirsyncer";
      };

      home.file = {
        ".config/vdirsyncer" = {
          source = ./sources;
          executable = false;
          recursive = true;
        };
      };

      home.packages = dependencies;
    }
  ]);
}
