{ pkgs, lib, config, ... }: {
  options = {
    bookmarks = {
      enable = lib.mkEnableOption "enables bookmarks";
    };
  };

  config = lib.mkIf config.bookmarks.enable (lib.mkMerge [
    {
      # config.wofi.enable = true;

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
