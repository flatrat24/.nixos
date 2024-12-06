{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    gnupg
    pinentry-tty
  ];
in {
  imports = [ ];

  options = {
    gpg = {
      enable = lib.mkEnableOption "enables gpg";
    };
  };

  config = lib.mkIf config.gpg.enable {
    home.packages = dependencies;

    programs.gpg = {
      enable = true;
      homedir = "${config.home.homeDirectory}/.gnupg";
    };

    services.gpg-agent = {
      enable = true;
    };
  };
}
