{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.imv;
  dependencies = with pkgs; [ imv ];
in {
  options = {
    imv.enable = lib.mkEnableOption "enable imv";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;

      home.file = {
        ".config/imv/config" = {
          source = ./sources/config;
          executable = false;
          recursive = false;
        };
      };

      xdg = {
        enable = lib.mkDefault true;
        mimeApps.enable = lib.mkDefault true;
        mimeApps.defaultApplications = {
          "image/*" = ["imv-dir.desktop"];
        };
      };
    }
    (lib.mkIf config.yazi.enable {
      programs.yazi.settings.opener = {
        image = [
          { run = ''imv "$@"''; orphan = true; desc = " imv"; }
        ];
      };
    })
  ]);
}
