{ pkgs, lib, inputs, config, ... }:
let
  dependencies = with pkgs; [ ];
in {
  imports = [ ];

  options = {
    email = {
      enable = lib.mkEnableOption "enable email";
      thunderbird.enable = lib.mkEnableOption "enables thunderbird";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf (config.email.enable == true) {
      home.packages = dependencies;
      accounts.email = {
        maildirBasePath = "Mail";
        accounts = {
          DU = {
            primary = true;
            address = "ethan.anthony@du.edu";
            realName = "Ethan Anthony";
            thunderbird = { # TODO: Thunderbird is spilling over into general email config
              enable = true;
              profiles = [ "Main" ];
            };
            flavor = "outlook.office365.com";
            imap = {
              tls.enable = true;
              port = 993;
              host = "outlook.office365.com";
            };
            smtp = {
              tls.useStartTls = true;
              port = 587;
              host = "smtp.office365.com";
            };
            signature = {
              # <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"><HTML><HEAD><TITLE>Email Signature</TITLE><META content="text/html; charset=utf-8" http-equiv="Content-Type"></HEAD><BODY style="font-size: 10pt; font-family: Arial, sans-serif;"><table style="width: 515px; font-size: 10pt; font-family: Arial, sans-serif; background: transparent !important;" cellpadding="0" cellspacing="0"><tbody><tr><td style="font-size: 14pt;  line-height: 16pt; color:#000e58; font-family: Arial, sans-serif; width: 514px; padding-bottom: 10px; vertical-align:top;" valign="top" colspan="2"><strong><span style="font-size: 14pt; font-family: Courier New, monospace; color:#000000;">Ethan Anthony</span></strong><br><span style="font-size: 10pt; font-family: Courier New, monospace; color:#363636;">LEP Tutor &amp; DU Residential Assistant</span></td></tr><tr><td style="font-size: 10pt; line-height: 12pt; border-top: 1px solid; border-top-color: #000000; color:#000000; font-family: Arial, sans-serif;  padding-top: 10px; vertical-align:top;" valign="top" colspan="2"><span style="font-size: 10pt; font-family: Courier New, monospace; color:#000000"><strong>University of Denver</strong><br></span><span style="font-size: 10pt; font-family: Courier New, monospace; color:#000000">BS Computer Engineering<br></span><span style="font-size: 10pt; font-family: Courier New, monospace; color:#000000">t: (919) 937-1931<br></span><span style="font-size: 10pt; font-family: Courier New, monospace; color:#000000;">e: ethan.anthony@du.edu<br></span> </td></tr><tr></tr><tr></tr></tbody></table></BODY></HTML>
              text = "placeholder";
              # command = "${maildirBase}/.sig/lukasz";
              showSignature = "none"; # TODO: Get better signature (append)
            };
            maildir.path = "DU";
          };
          gmail = {
            primary = false;
            address = "ethananthony271@gmail.com";
            realName = "Ethan Anthony";
            thunderbird = { # TODO: Thunderbird is spilling over into general email config
              enable = true;
              profiles = [ "Main" ];
            };
            flavor = "gmail.com";
            imap = {
              tls.enable = true;
              port = 993;
              host = "imap.gmail.com";
            };
            smtp = {
              tls.enable = true; # MAYBE CHANGE?
              port = 587;
              host = "smtp.gmail.com"; # MAYBE CHANGE?
            };
            signature = {
              text = "Ethan Anthony";
              showSignature = "none";
            };
            maildir.path = "gmail";
          };
        };
      };
    })
    (lib.mkIf (config.email.thunderbird.enable == true) { # TODO: Make it rely on both email and thunderbird options
      programs.thunderbird = {
        enable = true;
        settings = { };
        profiles = {
          "Main" = {
            isDefault = true;
            search = {
              force = true;
              default = "Startpage";
              privateDefault = "Startpage";
              order = [ "Startpage" ];
              engines = {
                "Startpage" = {
                  urls = [ { template = "https://www.startpage.com/rd/search?query={searchTerms}&language=auto"; } ];
                  definedAliases = [ "@s" ];
                };
              };
            };
          };
        };
      };
    })
  ];
}
