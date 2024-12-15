{ pkgs, ... }: {
  imports = [
    ./modules/ags
    ./modules/email
    ./modules/beeper
    ./modules/bookmarks
    ./modules/discord
    ./modules/firefox
    ./modules/foot
    ./modules/gaming
    ./modules/git
    ./modules/gpg
    ./modules/hypr
    ./modules/importMusic
    ./modules/passwords
    ./modules/music
    ./modules/neovim
    ./modules/shell
    ./modules/swayimg
    ./modules/theme
    ./modules/waybar
    ./modules/wofi
    ./modules/yazi
    ./modules/zathura
    ./modules/zellij
  ];
}
