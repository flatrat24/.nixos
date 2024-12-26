{ pkgs, lib, config, ... }:
let
  bookmarks = pkgs.writeShellApplication {
    name = "bookmarks.sh";
    runtimeInputs = [
      pkgs.jq
    ];
    text = builtins.readFile ./sources/bookmarks.sh;
  };
  # addBookmark = pkgs.writeShellApplication {
  #   name = "addBookmark.sh";
  #   runtimeInputs = [
  #     pkgs.wofi
  #     pkgs.jq
  #   ];
  #   text = builtins.readFile ./sources/addBookmark.sh;
  # };
  # openBookmark = pkgs.writeShellApplication {
  #   name = "openBookmark.sh";
  #   runtimeInputs = [
  #     pkgs.wofi
  #     pkgs.jq
  #   ];
  #   text = builtins.readFile ./sources/openBookmark.sh;
  # };
  dependencies = [
    # openBookmark
    # addBookmark
    bookmarks
  ];
in {
  options = {
    bookmarks = {
      enable = lib.mkEnableOption "enables bookmarks";
    };
  };

  config = lib.mkIf config.bookmarks.enable (lib.mkMerge [
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
          "$mod, m, Open Bookmark, exec, bookmarks.sh -o"
          "$mod SHIFT, m, Add Bookmark, exec, bookmarks.sh -c"
        ];
      };
    })
  ]);
}
