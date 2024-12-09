{ pkgs, lib, config, ... }: {
  imports = [ ];

  options = {
    gpg = {
      enable = lib.mkEnableOption "enables gpg";
    };
  };


  config = lib.mkIf config.gpg.enable (lib.mkMerge [
    {
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
    }
    (lib.mkIf config.shell.zsh.enable {
      services.gpg-agent.enableZshIntegration = true;
    })
    (lib.mkIf config.shell.bash.enable {
      services.gpg-agent.enableBashIntegration = true;
    })
  ]);
}
