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

   ./modules/hypr/
   ./modules/firefox.nix
   ./modules/foot.nix
   ./modules/git.nix
   ./modules/keepass.nix
   ./modules/mpd.nix
   ./modules/nvim.nix
   ./modules/sh.nix
   ./modules/stylix.nix
   ./modules/yazi.nix
   ./modules/zellij.nix
  ];
}
