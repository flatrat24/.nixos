{ pkgs, ... }: {
  imports = [
   # ./modules/hypr/
   # ./modules/firefox.nix
   # ./modules/foot.nix
   # ./modules/gaming.nix
   # ./modules/git.nix
   # ./modules/importMusic.nix
   # ./modules/keepass.nix
   # ./modules/mime.nix
   # ./modules/mpd.nix
   # ./modules/nvim.nix
   # ./modules/sh.nix
   # ./modules/stylix.nix
   # ./modules/swayimg.nix
   # ./modules/yazi.nix
   # ./modules/zathura.nix
   # ./modules/zellij.nix

   ./modules/hypr/default.nix
   ./modules/firefox/default.nix
   ./modules/foot/default.nix
   ./modules/git/default.nix
   ./modules/keepass/default.nix
   ./modules/mpd/default.nix
   ./modules/nvim/default.nix
   ./modules/sh/default.nix
   ./modules/stylix/default.nix
   ./modules/yazi/default.nix
   ./modules/zellij/default.nix
  ];
}
