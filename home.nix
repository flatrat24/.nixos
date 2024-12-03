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
    ./config/home/foot.nix
    ./config/home/keepass.nix

    # Other Modules
    ./config/home/mpd.nix
    ./config/home/hypr/default.nix
  ];

  home = {
    username = "ea";
    homeDirectory = "/home/ea";
    stateVersion = "24.05";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = null; # "${config.home.homeDirectory}/Desktop";
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    music = "${config.home.homeDirectory}/Music";
    pictures = null; # "${config.home.homeDirectory}/Pictures";
    publicShare = null; # "${config.home.homeDirectory}/Public";
    templates = null; # "${config.home.homeDirectory}/Templates";
    videos = null; # "${config.home.homeDirectory}/Videos";
  };

  programs.home-manager.enable = true;
}
