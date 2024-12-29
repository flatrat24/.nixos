{ config, ... }:

{
  imports = [
    ../../config/home/default.nix
  ];

  home = {
    username = "ea";
    homeDirectory = "/home/ea";
    stateVersion = "24.05";
  };

  ##--- Hardware ---##
  hardware = {
    monitor = "framework";
    keyboard = "framework";
    touchpad.enable = true;
  };

  ##--- Hyprland ---##
  hyprland.enable = true;

  ##--- Theme ---##
  theme = {
    enable = true;
    colorscheme = "catppuccin-mocha";
    wallpaper = "biking_sunset.jpg";
  };

  ##--- Applications ---###
  beeper.enable = true;
  discord.enable = true;
  firefox.enable = true;
  foot.enable = true;
  libreoffice.enable = true;
  mpv.enable = true;
  nautilus.enable = true;
  obs.enable = true;
  overskride.enable = true;
  slack.enable = true;
  swayimg.enable = true;
  teams.enable = true;
  zathura.enable = true;
  zed.enable = true;
  zoom.enable = true;

  ##--- Scripting Modules ---##
  bookmarks.enable = true;
  school.enable = true;
  notes.enable = true;

  ##--- Gaming ---##
  gaming = {
    enable = true;
    minecraft.enable = false;
    mindustry.enable = false;
    launchers = {
      bottles.enable = false;
      heroic.enable = false;
      lutris.enable = false;
    };
  };

  ##--- Other ---##
  gpg.enable = true;
  latex.enable = true;
  email = {
    enable = true;
    thunderbird.enable = true;
  };
  git.enable = true;
  passwords.enable = true;
  music.enable = true;
  neovim = {
    enable = true;
    plugins = {
      telescope.enable = true;
      fzf-lua.enable = false;
    };
  };
  shell.enable = true;
  power.enable = true;
  yazi.enable = true;
  zellij.enable = true;

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

  # For Virtual Machine to work? (https://nixos.wiki/wiki/Virt-manager)
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  programs.home-manager.enable = true;
}
