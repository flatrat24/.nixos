{ inputs, config, pkgs, ... }:

{
  imports = [
    ../../config/home/default.nix
  ];

  home = {
    username = "ea";
    homeDirectory = "/home/ea";
    stateVersion = "24.05";
  };

  firefox.enable = true;
  foot.enable = true;

  gaming = {
    enable = true;
  };

  git.enable = true;

  hypr = {
    enable = true;
    hyprlock = {
      enable = true;
      showMusic = true;
    };
    hyprpaper = {
      enable = true;
      wallpaper = ../../config/assets/grove.png;
    };
    animations = {
      enable = true;
    };
  };

  importMusic.enable = false;
  keepass.enable = true;
  mpd.enable = true;
  neovim.enable = true;
  shell.enable = true;
  swayimg.enable = true;
  theme.enable = true;
  yazi.enable = true;
  zathura.enable = true;
  zellij.enable = true;

  input = {
    touchpad.enable = true;
    keyboard = {
      formFactor = "ANSI";
    };
  };

  monitors = {
    microstepMSI.enable = false;
    framework.enable = true;
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
