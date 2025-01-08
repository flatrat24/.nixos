{ pkgs, lib, config, ... }:
let
  cfg = config.bookmarks;
  bookmarks = pkgs.writeShellApplication {
    name = "bookmarks.sh";
    runtimeInputs = [
      pkgs.jq
    ];
    text = builtins.readFile ./sources/bookmarks.sh;
  };
  dependencies = [
    bookmarks
  ];
in {
  options = {
    bookmarks = {
      enable = lib.mkEnableOption "enables bookmarks";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home = {
        packages = dependencies;
        sessionVariables = {
          BOOKMARKS = /home/ea/.bookmarks;
        };
      };
    }

    (lib.mkIf config.hyprland.enable {
      wayland.windowManager.hyprland.settings = {
        bindd = [
          "$mod, m, Open Bookmark, exec, bookmarks.sh -o && sleep 0.15s && hyprctl dispatch focusurgentorlast"
          "$mod SHIFT, m, Add Bookmark, exec, bookmarks.sh -c && cd ~/.bookmarks && git add . && git commit -m 'added bookmark' && git push && cd"
          "$mod SHIFT CTRL, m, Pull Bookmarks Git Repository, exec, cd ~/.bookmarks && git pull && cd || notify-send 'Error' 'Unable to pull bookmarks repository'"
        ];
      };
    })
  ]);
}
