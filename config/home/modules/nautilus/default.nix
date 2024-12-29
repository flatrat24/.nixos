{ pkgs, lib, config, ... }:
let
  cfg = config.nautilus;
  dependencies = with pkgs; [
    nautilus
  ];
in {
  imports = [ ];

  options = {
    nautilus = {
      enable = lib.mkEnableOption "enables nautilus";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
    (lib.mkIf config.yazi.enable {
      programs.yazi.settings.opener = {
        directory = [
          { run = ''nautilus "$@"''; orphan = true; desc = "󰪶 nautilus"; }
        ];
      };
    })
  ]);
}
