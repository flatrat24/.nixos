{ pkgs, lib, config, ... }: {
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
        maxCacheTtl = 7 * 24 * 60 * 60; # One week
        defaultCacheTtl = 7 * 24 * 60 * 60; # One week
      };
    };
  };
}
