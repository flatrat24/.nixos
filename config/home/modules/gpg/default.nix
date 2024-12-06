{ pkgs, lib, config, ... }:
# let
  # dependencies = with pkgs; [
  #   gnupg
  # ];
{ # in {
  imports = [ ];

  options = {
    gpg = {
      enable = lib.mkEnableOption "enables gpg";
    };
  };


  config = lib.mkIf config.gpg.enable {
    programs = {
      gpg = {
        enable = true;
        homedir = "${config.home.homeDirectory}/.gnupg";
      };
    };

    services = {
      gpg-agent = {
        enable = true;
        enableSshSupport = true;
        pinentryPackage = pkgs.pinentry-curses;
      };
    };
  };
}
