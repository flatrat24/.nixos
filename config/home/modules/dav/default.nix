{ pkgs, lib, config, ... }:
let
  cfg = config.khard;
  dependencies = with pkgs; [
    khard
    vdirsyncer
  ];
in {
  options = {
    khard.enable = lib.mkEnableOption "enables khard";
    vdirsyncer.enable = lib.mkEnableOption "enables vdirsyncer";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      services.vdirsyncer = {
        enable = true;
        package = pkgs.vdirsyncer;
        frequency = "15min";
      };

      programs.vdirsyncer = {
        enable = true;
        package = pkgs.vdirsyncer;
        statusPath = "~/.vdirsyncer";
      };

      home.file = {
        ".config/vdirsyncer" = {
          source = ./sources;
          executable = false;
          recursive = true;
        };
      };

      home.packages = dependencies;
    }
    {
      # programs.khard = {
      #   enable = true;
      #   # package = pkgs.khard;
      #   settings = {
      #     addressbooks = {
      #       default = "~/.contacts/default";
      #     };
      #
      #     general = {
      #       default_action = "list";
      #       editor = ["nvim"];
      #     };
      #
      #     "contact table" = {
      #       display = "formatted_name";
      #       preferred_phone_number_type = ["pref" "cell" "home"];
      #       preferred_email_address_type = ["pref" "work" "home"];
      #     };
      #
      #     vcard = { };
      #   };
      # };

      home.file = {
        ".config/khard/khard.conf" = lib.mkForce {
          text = ''
            [addressbooks]
            [[default]]
            path = ~/.contacts/default/

            [contact table]
            display=formatted_name
            preferred_email_address_type=pref, work, home
            preferred_phone_number_type=pref, cell, home

            [general]
            default_action=list
            editor=nvim

            [vcard]
          '';
          executable = false;
        };
      };

      home.packages = dependencies;
    }
  ]);
}
