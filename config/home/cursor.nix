{ pkgs, ... }:
let
  dependencies = with pkgs; [
    apple-cursor
  ];
in {

  gtk.cursorTheme = {
    package = pkgs.apple-cursor;
  };

  home.packages = dependencies;
}
