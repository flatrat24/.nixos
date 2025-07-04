{ lib, config, ... }:
let
  cfg = config.email;
  dependencies = [ ];
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
          general.unsafe-accounts-conf = true;
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
