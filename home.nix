{ inputs, config, pkgs, ... }:

{
  imports = [
    # General Modules
    ./config/home/stylix.nix
    # ./config/home/mime.nix

    # Shell/Terminal Modules
    ./config/home/sh.nix
    ./config/home/yazi.nix
    ./config/home/zellij.nix
    ./config/home/git.nix
    ./config/home/nvim.nix

    # Application Modules
    ./config/home/firefox.nix

    # Other Modules
    # ./config/home/mpd.nix
    ./config/home/hypr/default.nix
  ];

  home = {
    username = "ea";
    homeDirectory = "/home/ea";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
