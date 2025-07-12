{ pkgs, lib, config, ... }:
let
  cfg = config.dav;
  dependencies = with pkgs; [
    khal
    khard
    vdirsyncer
  ];
in {
  options = {
    dav = {
      enable = lib.mkEnableOption "enables webdav (caldav/carddav)";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
    {
      home.file = {
        ".config/vdirsyncer" = {
          source = ./sources/vdirsyncer;
          executable = false;
          recursive = true;
        };
      };
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
    }
    {
      home.file = {
        ".config/khal/config" = lib.mkForce {
          text = ''
            [calendars]

            [[personal]]
            path = ~/.calendar/personal

            [[work]]
            path = ~/.calendar/work

            [[birthdays]]
            path = ~/.contacts

            [default]
            timedelta = 5d
            default_calendar = personal

            [keybindings]
            delete = x
            duplicate = d
            export = e
            external_edit = E
            log = L
            mark = v
            new = i
            other = tab
            quit = q
            save = w
            search = /
            today = t
            view = enter
            left = h
            down = j
            up = k
            right = l

            [locale]
            firstweekday = 0
            timeformat = %H:%M
            dateformat = %m/%d/%Y
            longdateformat = %m/%d/%Y
            datetimeformat = %m/%d/%Y %H:%M
            longdatetimeformat = %m/%d/%Y %H:%M
          '';
          executable = false;
        };
      };
    }
    {
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
    }
  ]);
}
