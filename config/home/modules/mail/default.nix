{ pkgs, lib, config, ... }:
let
  cfg = config.email;
  dependencies = with pkgs; [
    glow
    pandoc
  ];
in {
  imports = [ ];

  options = {
    email = {
      enable = lib.mkEnableOption "enable email";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.mbsync.enable = true;
    }
    # {
    #   services.imapnotify = {
    #     enable = true;
    #     path = with pkgs; [
    #       coreutils
    #       python3
    #       libnotify
    #       offlineimap
    #       gnupg
    #       notmuch
    #       sops
    #     ];
    #   };
    # }
    {
      programs.aerc = {
        enable = true;
        extraConfig = {
          general = {
            unsafe-accounts-conf = true;
            pgp-provider = "gpg";
            term = "foot";
          };
          "multipart-converters" = {
            "text/html" = "${pkgs.pandoc}/bin/pandoc -f html -t markdown --standalone | ${pkgs.glow}/bin/glow";
          };
          compose = {
            no-attachment-warning = "(attach|attached|attachments?)";
            address-book-cmd = "khard email --parsable %s";
          };
          filters = {
            ".headers" = "${pkgs.aerc}/libexec/aerc/filters/colorize";
            "text/calendar" = "${pkgs.gawk}/bin/awk -f ${pkgs.aerc}/libexec/aerc/filters/calendar";
            "text/html" = "${pkgs.pandoc}/bin/pandoc -f html -t markdown --standalone | ${pkgs.glow}/bin/glow";
            "text/plain" = "${pkgs.aerc}/libexec/aerc/filters/colorize";
            "text/*" = "${pkgs.bat}/bin/bat";
            "message/delivery-status" = "colorize";
            "message/rfc822" = "colorize";
            "application/pdf" = "${pkgs.zathura}/bin/zathura -";
            "application/x-sh" = "${pkgs.bat}/bin/bat -fP -l sh";
            "audio/*" = "${pkgs.mpv}/bin/mpv -";
          };
          ui = {
            index-column = "flags:4,name<20%,subject,date>=";
            sidebar-width = 14;
            mouse-enabled = true;
            new-message-bell = false;
            spinner = ".  ,.. ,..., ..,  ., ..,...,.. ";
            spinner-interval = "100ms";
            auto-mark-read = false;
            icon-encrypted   = "e"; # 󰯅
            icon-attachment  = "a"; # 󰏢
            icon-new         = "n"; # *
            icon-old         = "n"; # *
            icon-flagged     = "f"; # 󰈾
            icon-deleted     = "d"; # 󰧧
            icon-unencrypted = ""; # 󰒙
            icon-signed      = "s"; # 󱦹
            icon-unknown     = "?"; # ?
            icon-invalid     = "!"; # !
            icon-replied     = "r"; # 󱞧
            icon-forwarded   = ""; # 󱞫
            icon-marked      = "x"; # x
            icon-draft       = ""; # 󰟷
          };
        };
        extraAccounts = {
          purelymail = {
            postpone = "drafts";
            copy-to = "sent";
            default = "inbox";
            from = "Ethan Anthony <ethananthony@worldofmail.com>";
            folders-sort = "inbox,drafts,sent,archive,trash,junk";
            source = "maildir://${config.accounts.email.maildirBasePath}/purelymail";
            outgoing = "smtps+plain://ethananthony@worldofmail.com@smtp.purelymail.com:465";
            outgoing-cred-cmd = "pass show purelymail.com/ethananthony@worldofmail.com | sed -n '1p'";
            check-mail-cmd = "mbsync purelymail";
            check-mail-timeout = "30s";
          };
        };
        extraBinds = {
          global = {
            "<c-l>" = ":next-tab<enter>";
            "<c-h>" = ":prev-tab<enter>";
            "?"     = ":help keys<enter>";
          };
          messages = {
            # General
            "q" = ":quit<enter>";
            "Q" = ":quit -f<enter>";
            "?" = ":help keys<enter>";

            # Pane Management
            "<C-m>"   = ":vsplit<enter>";
            "<C-n>"   = ":hsplit<enter>";
            "<C-S-h>" = ":hsplit -3<enter>";
            "<C-S-j>" = ":vsplit -3<enter>";
            "<C-S-k>" = ":vsplit +3<enter>";
            "<C-S-l>" = ":hsplit +3<enter>";

            # Actions
            "C"         = ":compose<enter>";
            "D"         = ":delete<enter>";
            "A"         = ":archive flat";
            "T"         = ":toggle-threads<enter>";
            "|"         = ":pipe<space>";
            "<enter>"   = ":view<enter>";

            "<space>" = ":mark -t<enter>:next<enter>";
            "v"       = ":mark -v<enter>";

            "cc" = ":cf<space>";
            "ca" = ":cf Archive <enter>";
            "cd" = ":cf Drafts <enter>";
            "ci" = ":cf INBOX <enter>";
            "cj" = ":cf Junk <enter>";
            "cs" = ":cf Sent <enter>";
            "ct" = ":cf Trash <enter>";

            "zl" = ":unfold<enter>";
            "zL" = ":unfold -a<enter>";
            "zh" = ":fold<enter>";
            "zH" = ":fold -a<enter>";
            "zz" = ":fold -t<enter>";
            "zZ" = ":fold -at<enter>";

            "rr" = ":reply<enter>";
            "rq" = ":reply -q<enter>";
            "Rr" = ":reply -a<enter>";
            "Rq" = ":reply -qa<enter>";

            # Navigation
            "H" = ":collapse-folder<enter>";
            "J" = ":next-folder<enter>";
            "K" = ":prev-folder<enter>";
            "L" = ":expand-folder<enter>";
            "j" = ":next<enter>";
            "k" = ":prev<enter>";
            # "J"   = ":next 5<enter>";
            # "K"   = ":prev 5<enter>";
            "G"   = ":select -1";
            "gg"  = ":select 0";
            "f"   = ":filter<space>";
            "/"   = ":search<space>";
            "N"   = ":prev-result<enter>";
            "n"   = ":next-result<enter>";
            "Esc" = ":clear<enter>";
          };
          view = {
            "q" = ":close<enter>";
            "O" = ":open<enter>";
            "S" = ":save<space>";
            "|" = ":pipe<space>";
            "D" = ":move Trash<enter>";
            "A" = ":archive flat<enter>";

            "J" = ":next<enter>";
            "K" = ":prev<enter>";

            "rr" = ":reply<enter>";
            "rq" = ":reply -q<enter>";
            "Rq" = ":reply -qa<enter>";
          };
          compose = { # Keybindings used when the embedded terminal is not selected in the compose
            "$noinherit" = "true";
            "$ex" = "<C-x>";
            "$complete" = "<C-j>";
            "<C-q>" = ":abort<Enter>";
            "<C-p>" = ":prev-field<Enter>";
            "<C-n>" = ":next-field<Enter>";
            "<C-a>" = ":switch-account -p<Enter>";
            "<C-A>" = ":switch-account -n<Enter>";
            "<C-l>" = ":next-tab<Enter>";
            "<C-h>" = ":prev-tab<Enter>";
          };
          "compose::editor" = { # Keybindings used when the embedded terminal is selected in the compose view
            "$noinherit" = "true";
            "$ex" = "<C-x>";
            "<C-q>" = ":abort<Enter>";
            "<C-p>" = ":prev-field<Enter>";
            "<C-n>" = ":next-field<Enter>";
            "<C-h>" = ":prev-tab<Enter>";
            "<C-l>" = ":next-tab<Enter>";
          };
          "compose::review" = { # Keybindings used when reviewing a message to be sent
            "y" = ":send<Enter>";
            "n" = ":abort<Enter>";
            "p" = ":postpone<Enter>";
            "q" = ":choose -o d discard abort -o p postpone postpone<Enter>";
            "e" = ":edit<Enter>";
            "a" = ":attach<space>";
            "d" = ":detach<space>";
          };
        };
        # stylesets = {
        #   default = {
        #     "*.default" = "true";
        #     "*.normal" = "true";
        #
        #     "default.fg" = "#EBFAFA";
        #
        #     "error.fg" = "#F9515D";
        #     "warning.fg" = "#E9F941";
        #     "success.fg" = "#37F499";
        #
        #     "tab.fg" = "#EBFAFA";
        #     "tab.bg" = "#212337";
        #     "tab.selected.fg" = "#CBDADA";
        #     "tab.selected.bg" = "#212337";
        #     "tab.selected.bold" = "true";
        #
        #     "border.fg" = "#212337";
        #     "border.bold" = "true";
        #
        #     "msglist_unread.bold" = "true";
        #     "msglist_flagged.fg" = "#E9F941";
        #     "msglist_flagged.bold" = "true";
        #     "msglist_result.fg" = "#9071F4";
        #     "msglist_result.bold" = "true";
        #     "msglist_*.selected.bold" = "true";
        #     "msglist_*.selected.bg" = "#212337";
        #
        #     "dirlist_*.selected.bold" = "true";
        #     "dirlist_*.selected.bg" = "#212337";
        #
        #     "statusline_default.fg" = "#EBFAFA";
        #     "statusline_default.bg" = "#212337";
        #     "statusline_error.bold" = "true";
        #     "statusline_success.bold" = "true";
        #
        #     "completion_default.selected.bg" = "#212337";
        #   };
        #   viewer = {
        #     "url.fg" = "#04D1F9";
        #     "url.underline" = "true";
        #     "header.bold" = "true";
        #     "signature.dim" = "true";
        #     "diff_meta.bold" = "true";
        #     "diff_chunk.fg" = "#04D1F9";
        #     "diff_chunk_func.fg" = "#04D1F9";
        #     "diff_chunk_func.bold" = "true";
        #     "diff_add.fg" = "#37F499";
        #     "diff_del.fg" = "#F9515D";
        #     "quote_*.fg" = "#EBFAFA";
        #   };
        # };
      };
    }
    {
      accounts.email = {
        maildirBasePath = "mail";
        accounts = {
          purelymail = {
            primary = true;
            address = "ethananthony@worldofmail.com";
            userName = "ethananthony@worldofmail.com";
            # passwordCommand = "pass show purelymail.com/ethananthony@worldofmail.com | sed -n '1p'";
            passwordCommand = "pass show purelymail.com/ethananthony@worldofmail.com";
            realName = "Ethan Anthony";
            flavor = "plain";
            imap = {
              tls.enable = true;
              port = 993;
              host = "imap.purelymail.com";
            };
            smtp = {
              tls.enable = lib.mkDefault true;
              port = lib.mkDefault 465;
              host = "smtp.purelymail.com";
            };
            signature = {
              text = "Ethan Anthony";
              showSignature = "none";
            };
            aerc = { # Doesn't play well with maildir
              enable = false;
            };
            # imapnotify = {
            #   enable = true;
            #   boxes = [
            #     "inbox"
            #   ];
            #   onNotifyPost = {
            #     mail = "${pkgs.libnotify}/bin/notify-send 'New mail arrived!'";
            #   };
            #   onNotify = "${pkgs.isync}/bin/mbsync -a";
            #   };
            mbsync = {
              enable = true;
              create = "both";
              expunge = "both";
              remove = "both";
              groups."purelymail" = {
                channels = {
                  inbox = {
                    farPattern = "INBOX";
                    nearPattern = "inbox";
                    extraConfig = {
                      Create = "both";
                      Expunge = "both";
                      SyncState = "*";
                    };
                  };
                  sent = {
                    farPattern = "Sent";
                    nearPattern = "sent";
                    extraConfig = {
                      Create = "both";
                      Expunge = "both";
                      SyncState = "*";
                    };
                  };
                  drafts = {
                    farPattern = "Drafts";
                    nearPattern = "drafts";
                    extraConfig = {
                      Create = "both";
                      Expunge = "both";
                      SyncState = "*";
                    };
                  };
                  archive = {
                    farPattern = "Archive";
                    nearPattern = "archive";
                    extraConfig = {
                      Create = "both";
                      Expunge = "both";
                      SyncState = "*";
                    };
                  };
                  junk = {
                    farPattern = "Junk";
                    nearPattern = "junk";
                    extraConfig = {
                      Create = "both";
                      Expunge = "both";
                      SyncState = "*";
                    };
                  };
                  trash = {
                    farPattern = "Trash";
                    nearPattern = "trash";
                    extraConfig = {
                      Create = "both";
                      Expunge = "both";
                      SyncState = "*";
                    };
                  };
                };
              };
            };
          };
        };
      };
    }
    {
      home.packages = dependencies;
    }
  ]);
}
