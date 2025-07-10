{ pkgs, lib, config, ... }:
let
  cfg = config.email;
  dependencies = with pkgs; [
    glow
    w3m
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
      programs.aerc = {
        enable = true;
        extraConfig = {
          general = {
            unsafe-accounts-conf = true;
            pgp-provider = "gpg";
            term = "foot";
          };
          "multipart-converters" = {
            # "text/html" = "${pkgs.pandoc}/bin/pandoc -f html -t markdown --standalone | ${pkgs.glow}/bin/glow";
            "text/html" = "w3m -dump -T text/html -o display_link_number=true";
          };
          filters = {
            ".headers" = "${pkgs.aerc}/libexec/aerc/filters/colorize";
            "text/calendar" = "${pkgs.gawk}/bin/awk -f ${pkgs.aerc}/libexec/aerc/filters/calendar";
            # "text/html" = "${pkgs.pandoc}/bin/pandoc -f html -t markdown --standalone | ${pkgs.glow}/bin/glow";
            "text/html" = "w3m -dump -T text/html -o display_link_number=true";
            # "text/plain" = "${pkgs.aerc}/libexec/aerc/filters/colorize";
            "text/plain" = "colorize";
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
            icon-encrypted = "󰯅";
            icon-attachment = "󰏢";
            icon-new = "*";
            icon-old = "*";
            icon-flagged = "󰈾";
            icon-deleted = "󰧧";
            icon-unencrypted = ""; # 󰒙
            icon-signed = "󱦹";
            icon-unknown = "?";
            icon-invalid = "!";
            icon-replied = "󱞧";
            icon-forwarded = "󱞫";
            icon-marked = "x";
            icon-draft = "󰟷";
          };
        };
        extraAccounts = {
          purelymail = {
            folder-map = "${pkgs.writeText "folder-map" ''
              Inbox = INBOX
            ''}";
            "folders-sort" = "Inbox,Drafts,Sent,Archive,Trash,Junk";
          };
        };
        extraBinds = {
          global = {
            "<tab>"     = ":next-tab<enter>";
            "<backtab>" = ":next-tab<enter>";
            "?"         = ":help keys<enter>";
          };
          messages = {
            # General
            "q" = ":quit<enter>";
            "?" = ":help keys<enter>";

            # Pane Management
            "<C-m>"   = ":vsplit<enter>";
            "<C-n>"   = ":hsplit<enter>";
            "<C-S-h>" = ":hsplit -3<enter>";
            "<C-S-j>" = ":vsplit -3<enter>";
            "<C-S-k>" = ":vsplit +3<enter>";
            "<C-S-l>" = ":hsplit +3<enter>";

            # Actions
            "C"   = ":compose<enter>";
            "D"   = ":delete<enter>";
            "A"   = ":archive flat";
            "T"   = ":toggle-threads<enter>";
            "|"   = ":pipe<space>";
            "<enter>"   = ":view<enter>";

            "<space>" = ":mark -t<enter>:next<enter>";
            "v" = ":mark -v<enter>";

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

            "rr"   = ":reply<enter>";
            "rq"   = ":reply -q<enter>";
            "Rr"   = ":reply -a<enter>";
            "Rq"   = ":reply -qa<enter>";

            # Navigation
            "<c-h>" = ":collapse-folder<enter>";
            "<c-j>" = ":next-folder<enter>";
            "<c-k>" = ":prev-folder<enter>";
            "<c-l>" = ":expand-folder<enter>";
            "j" = ":next<enter>";
            "k" = ":prev<enter>";
            "J"   = ":next 5<enter>";
            "K"   = ":prev 5<enter>";
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
          compose = {
            "$noinherit" = "true";
            "$ex" = "<C-x>";
            "<C-k>" = ":prev-field<Enter>";
            "<C-j>" = ":next-field<Enter>";
            "<C-h>" = ":switch-account -p<Enter>";
            "<C-l>" = ":switch-account -n<Enter>";
            "<tab>" = ":next-tab<Enter>";
            "<backtab>" = ":prev-tab<Enter>";
          };
          "compose::review" = {
            "y" = ":send<Enter>";
            "n" = ":abort<Enter>";
            "p" = ":postpone<Enter>";
            "q" = ":choose -o d discard abort -o p postpone postpone<Enter>";
            "e" = ":edit<Enter>";
            "a" = ":attach<space>";
            "d" = ":detach<space>";
          };
        };
        stylesets = {
          default = {
            "*.default" = "true";
            "*.normal" = "true";

            "default.fg" = "#cdd6f4";

            "error.fg" = "#f38ba8";
            "warning.fg" = "#fab387";
            "success.fg" = "#a6e3a1";

            "tab.fg" = "#6c7086";
            "tab.bg" = "#181825";
            "tab.selected.fg" = "#cdd6f4";
            "tab.selected.bg" = "#1e1e2e";
            "tab.selected.bold" = "true";

            "border.fg" = "#11111b";
            "border.bold" = "true";

            "msglist_unread.bold" = "true";
            "msglist_flagged.fg" = "#f9e2af";
            "msglist_flagged.bold" = "true";
            "msglist_result.fg" = "#89b4fa";
            "msglist_result.bold" = "true";
            "msglist_*.selected.bold" = "true";
            "msglist_*.selected.bg" = "#313244";

            "dirlist_*.selected.bold" = "true";
            "dirlist_*.selected.bg" = "#313244";

            "statusline_default.fg" = "#9399b2";
            "statusline_default.bg" = "#313244";
            "statusline_error.bold" = "true";
            "statusline_success.bold" = "true";

            "completion_default.selected.bg" = "#313244";
          };
        };
      };
    }
    {
      home.packages = dependencies;
      accounts.email = {
        maildirBasePath = ".mail";
        accounts = {
          purelymail = {
            primary = true;
            address = "ethananthony@worldofmail.com";
            userName = "ethananthony@worldofmail.com";
            passwordCommand = "pass show purelymail.com/ethananthony@worldofmail.com | sed -n '1p'";
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
            maildir.path = "purelymail";

            aerc = {
              enable = true;
            };
          };
        };
      };
    }
  ]);
}
