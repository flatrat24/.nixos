{ pkgs, ... }: {

  gtk.cursorTheme = {
    package = pkgs.apple-cursor;
  };

  home.packages = with pkgs; [
    apple-cursor
  ];
}
