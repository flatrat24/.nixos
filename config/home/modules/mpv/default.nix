{ pkgs, lib, config, ... }:
let
  cfg = config.mpv;
in {
  imports = [ ];

  options = {
    mpv = {
      enable = lib.mkEnableOption "enables mpv";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.mpv = {
        enable = true;
        scripts = with pkgs.mpvScripts; [
          sponsorblock
          mpv-cheatsheet
        ];
      };
    }
    (lib.mkIf config.yazi.enable {
      programs.yazi.settings.opener = {
        video = [
          { run = ''mpv "$@"''; orphan = true; desc = " mpv"; }
        ];
        image = [
          { run = ''mpv "$@"''; orphan = true; desc = " mpv"; }
        ];
      };
    })
  ]);
}
