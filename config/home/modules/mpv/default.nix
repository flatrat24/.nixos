{ pkgs, lib, config, ... }: {
  imports = [ ];

  options = {
    mpv = {
      enable = lib.mkEnableOption "enables mpv";
    };
  };

  config = lib.mkIf config.mpv.enable (lib.mkMerge [
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
