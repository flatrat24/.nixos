{ pkgs, lib, config, ... }: {
  options = {
    basics.enable = lib.mkEnableOption "enables basic";
  };

  config = lib.mkIf config.basics.enable {
    environment.systemPackages = with pkgs; [
      wget
      git
    ];

    programs.zsh.enable = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    time.timeZone = "America/Denver";
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    hardware.graphics = {
      enable = true;
    };

    services.pcscd.enable = true; # Helps with GPG, idk why

    nix.gc.automatic = true; # Automatically garbage collect
    nix.settings.auto-optimise-store = true; # Automatically optimize nix store

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      xdgOpenUsePortal = true;
    };

    # For gnome-calendar
    programs.dconf.enable = true;
    services.gnome = {
      evolution-data-server.enable = true;
      gnome-online-accounts.enable = true;
      gnome-keyring.enable = true;
    };

    # For AppImages
    programs.appimage = {
      enable = true;
      binfmt = true;
    };

    # SSH Support
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };
  };
}
