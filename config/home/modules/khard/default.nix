{ pkgs, lib, config, ... }:
let
  cfg = config.khard;
  dependencies = with pkgs; [
    khard
  ];
in {
  options = {
    khard.enable = lib.mkEnableOption "enables khard";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
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
