{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    libreoffice
  ];
in {
  imports = [ ];

  options = {
    libreoffice = {
      enable = lib.mkEnableOption "enables libreoffice";
    };
  };

  config = lib.mkIf config.libreoffice.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
    (lib.mkIf config.yazi.enable {
      programs.yazi.settings.opener = {
        pdf = [
          { run = ''libreoffice "$@"''; orphan = true; desc = " LibreOffice"; }
        ];
        video = [
          { run = ''libreoffice "$@"''; orphan = true; desc = " LibreOffice"; }
        ];
        image = [
          { run = ''libreoffice "$@"''; orphan = true; desc = " LibreOffice"; }
        ];
        office = [
          { run = ''libreoffice "$@"''; orphan = true; desc = " LibreOffice"; }
        ];
      };
    })
  ]);
}
