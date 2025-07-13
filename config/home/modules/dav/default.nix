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
        ".config/vdirsyncer/config" = lib.mkForce {
          text = ''
            [general]
            status_path = "~/.vdirsyncer/status/"

            [pair contacts]
            a = "contacts_local"
            b = "contacts_purelymail"
            collections = ["from a", "from b"]

            [storage contacts_local]
            type = "filesystem"
            path = "~/.contacts/"
            fileext = ".vcf"

            [storage contacts_purelymail]
            type = "carddav"
            url = "https://purelymail.com/webdav/153315/carddav/"
            username = "ethananthony@worldofmail.com"
            password.fetch = [ "shell", "pass show purelymail.com/ethananthony@worldofmail.com | sed -n '1p'" ]

            [pair calendar]
            a = "calendar_local"
            b = "calendar_purelymail"
            collections = ["from a", "from b"]
            metadata = ["displayname", "color"]

            [storage calendar_local]
            type = "filesystem"
            path = "~/.calendar/"
            fileext = ".ics"

            [storage calendar_purelymail]
            type = "caldav"
            url = "https://purelymail.com/webdav/153315/caldav/"
            username = "ethananthony@worldofmail.com"
            password.fetch = [ "shell", "pass show purelymail.com/ethananthony@worldofmail.com | sed -n '1p'" ]
          '';
        };
      };
      services.vdirsyncer = {
        enable = true;
        package = pkgs.vdirsyncer;
        frequency = "15min";
      };
    }
    {
      home.file = {
        ".config/khal/config" = lib.mkForce {
          text = ''
            [calendars]

            [[personal]]
            path = ~/.calendar/personal
            color = light green
            priority = 1

            [[work]]
            path = ~/.calendar/work
            color = yellow
            priority = 0

            [[birthdays]]
            path = ~/.contacts/default
            color = light blue
            priority = 0

            [default]
            timedelta = 5d
            highlight_event_days = true
            print_new = event
            default_calendar = personal

            [keybindings]
            delete = D
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
            datetimeformat = %m/%d %H:%M
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
