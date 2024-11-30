{ config, pkgs, ... }:

{
  imports = [
    ./config/home/sh.nix
    ./config/home/yazi.nix
    ./config/home/zellij.nix
    ./config/home/fonts.nix
    ./config/home/git.nix
    # ./config/home/mpd.nix
    ./config/home/hypr.nix
  ];

  home = {
    username = "ea";
    homeDirectory = "/home/ea";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
