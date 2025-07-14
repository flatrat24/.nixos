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
  dav.enable = true;
  beeper.enable = true;
  better-control.enable = false;
  bottles.enable = false;
  calculator.enable = true;
  calendar.enable = false;
  digital.enable = true;
  discord.enable = false;
  fabric.enable = false;
  firefox.enable = true;
  foot.enable = true;
  geogebra.enable = false;
  ignis.enable = false;
  imv.enable = true;
  libreoffice.enable = true;
  magic-wormhole.enable = true;
  mpv.enable = true;
  nautilus.enable = true;
  nyxt.enable = false;
  obs.enable = false;
  octave.enable = false;
  overskride.enable = false;
  pinta.enable = false;
  rss.enable = false;
  rtorrent.enable = false;
  slack.enable = false;
  swayimg.enable = false;
  teams.enable = false;
  thunderbird.enable = true;
  whatsapp.enable = false;
  zathura.enable = true;
  zenBrowser.enable = false;
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
      heroic.enable = false;
      lutris.enable = false;
    };
  };

  ##--- Other ---##
  gpg.enable = true;
  latex.enable = true;
  email.enable = true;
  git.enable = true;
  passwords.enable = true;
  music.enable = true;
  neovim = {
    enable = true;
    plugins = {
      telescope.enable = true;
      fzf-lua.enable = false;
      highlight-undo.enable = false;
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

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  programs.home-manager.enable = true;
}
