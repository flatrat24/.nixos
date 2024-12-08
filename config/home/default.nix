{ pkgs, ... }: {
  imports = [
    ./modules/email/default.nix
    ./modules/beeper/default.nix
    ./modules/discord/default.nix
    ./modules/firefox/default.nix
    ./modules/foot/default.nix
    ./modules/gaming/default.nix
    ./modules/git/default.nix
    ./modules/gpg/default.nix
    ./modules/hypr/default.nix
    ./modules/importMusic/default.nix
    ./modules/passwords/default.nix
    ./modules/music/default.nix
    ./modules/neovim/default.nix
    ./modules/shell/default.nix
    ./modules/swayimg/default.nix
    ./modules/theme/default.nix
    ./modules/wofi/default.nix
    ./modules/yazi/default.nix
    ./modules/zathura/default.nix
    ./modules/zellij/default.nix
  ];
}
