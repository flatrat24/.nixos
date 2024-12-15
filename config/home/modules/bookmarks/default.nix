{ pkgs, lib, config, ... }:
let
  importMusic = pkgs.writeShellApplication {
    name = "importMusic";
    runtimeInputs = with pkgs; [
      yt-dlp
      beets
      gnused
    ];
    text = builtins.readFile ./sources/importMusic;
  };
  mpdDependencies = with pkgs; [
    mpd
    mpc-cli
    mpdscribble
    mpd-notification
  ];
  ncmpcppDependencies = with pkgs; [
    ncmpcpp
  ];
  importMusicDependencies = [
    importMusic
    pkgs.beets
    pkgs.yt-dlp
  ];
in {
  options = {
    bookmarks = {
      enable = lib.mkEnableOption "enables bookmarks";
    };
  };

  config = lib.mkIf config.bookmarks.enable (lib.mkMerge [
    {
      config.wofi.enable = true;

      home.file = {
        ".bookmarks" = {
          source = ./sources;
          executable = true;
          recursive = true;
        };
      };
    }
    
    (lib.mkIf config.hypr.enable {
      wayland.windowManager.hyprland.settings = {
        bindd = [
          "$mod, m, Open Bookmark, exec, $HOME/.bookmarks/openBookmark.sh"
          "$mod SHIFT, m, Add Bookmark, exec, $HOME/.bookmarks/addBookmark.sh"
        ];
      };
    })
  ]);
}
