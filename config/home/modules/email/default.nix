{ lib, config, ... }:
let
  cfg = config.email;
  dependencies = [ ];
in {
  imports = [ ];

  options = {
    email = {
      enable = lib.mkEnableOption "enable email";
      thunderbird.enable = lib.mkEnableOption "enables thunderbird";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
      accounts.email = { # authentication not really working with this
        maildirBasePath = "Mail";
        accounts = {
          DU = {
            primary = true;
            address = "ethan.anthony@du.edu";
            realName = "Ethan Anthony";
            thunderbird = { # TODO: Thunderbird is spilling over into general email config
              enable = false;
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
              enable = false;
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
              port = lib.mkDefault 587;
              host = lib.mkDefault "smtp.gmail.com"; # MAYBE CHANGE?
            };
            signature = {
              text = "Ethan Anthony";
              showSignature = "none";
            };
            maildir.path = "gmail";
          };
        };
      };
    }
    (lib.mkIf (cfg.thunderbird.enable == true) (lib.mkMerge [
      {
        home = {
          file = {
            ".thunderbird" = {
              source = ./sources;
              executable = false;
              recursive = true;
            };
          };
        };

        programs.thunderbird = {
          enable = true;
          settings = {
            # General
            "app.donation.eoy.version.viewed" = 1000;
            "mail.rights.version" = 1;
            "mail.shell.checkDefaultClient" = false;
            "mailnews.start_page.enabled" = false;

            # Phishing detection
            "mail.phishing.detection.enabled" = false;

            # Telemetry
            "datareporting.healthreport.uploadEnabled" = false;
            "datareporting.policy.dataSubmissionEnabled" = false;

            # UI
            "apz.overscroll.enabled" = true;
            "mail.biff.play_sound" = false; # Disable notification sound
            "msgcompose.default_colors" = false;
            "msgcompose.background_color" = "#EEEEFF";
            "font.name.sans-serif.x-western" = "IBM Plex Sans";
          };
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
      }
      (lib.mkIf config.hyprland.enable {
        wayland.windowManager.hyprland.settings.windowrulev2 = [
          # Sign in
          "float,title:(Sign in to your account)(.*),class:thunderbird"
          "size 50% 50%,title:(Sign in to your account)(.*),class:thunderbird"
          "center 1,title:(Sign in to your account)(.*),class:thunderbird"

          # Edit Calendar
          "float,title:Edit Calendar,class:thunderbird"
          "size 50% 50%,title:Edit Calendar,class:thunderbird"
          "center 1,title:Edit Calendar,class:thunderbird"

          # Subscribing to a new calendar
          "float,title:Create New Calendar,class:thunderbird"
          "size 50% 50%,title:Create New Calendar,class:thunderbird"
          "center 1,title:Create New Calendar,class:thunderbird"

          # New calendar item
          "float,initialTitle:Edit Item,class:thunderbird"
          "size 30% 80%,initialTitle:Edit Item,class:thunderbird"
          "center 1,initialTitle:Edit Item,class:thunderbird"

          # Custom repeat for calendar events
          "float,title:Edit Recurrence,class:thunderbird"
          "size 60% 72%,title:Edit Recurrence,class:thunderbird"
          "center 1,title:Edit Recurrence,class:thunderbird"

          # Custom reminders
          "float,title:Set up Reminders,class:thunderbird"
          "size 60% 70%,title:Set up Reminders,class:thunderbird"
          "center 1,title:Set up Reminders,class:thunderbird"

          # Double click on a calendar item
          "float,initialTitle:^$,class:thunderbird"
          "size 50% 50%,initialTitle:^$,class:thunderbird"
          "center 1,initialTitle:^$,class:thunderbird"

          # Copy repeating event dialogue
          "float,title:Copy Repeating Event,class:thunderbird"
          "size 40% 40%,title:Copy Repeating Event,class:thunderbird"
          "center 1,title:Copy Repeating Event,class:thunderbird"

          # Select calendar (to paste an even into)
          "float,title:Copy Repeating Event,class:thunderbird"
          "size 20% 30%,title:Copy Repeating Event,class:thunderbird"
          "center 1,title:Copy Repeating Event,class:thunderbird"

          # Event reminders
          "float,title:Calendar Reminders,class:thunderbird"
          "size 50% 50%,title:Calendar Reminders,class:thunderbird"
          "center 1,title:Calendar Reminders,class:thunderbird"

          # Send Message Confirmation
          "float,title:Send Message,class:thunderbird"
          "size 450 150,title:Send Message,class:thunderbird"
          "center 1,title:Send Message,class:thunderbird"

          # Sending Message Dialogue
          "float,title:([0-9]+)( Reminder),class:thunderbird"
          "size 50% 50%,title:([0-9]+)( Reminder),class:thunderbird"
          "center 1,title:([0-9]+)( Reminder),class:thunderbird"

          # Sending Message Dialogue
          "float,title:(Sending Message - )(.*),class:thunderbird"
          "size 450 120,title:(Sending Message - )(.*),class:thunderbird"
          "center 1,title:(Sending Message - )(.*),class:thunderbird"

          # Save Message Dialogue
          "float,title:Save Message,class:thunderbird"
          "size 450 150,title:Save Message,class:thunderbird"
          "center 1,title:Save Message,class:thunderbird"

          # Confirm Deletion
          "float,title:Confirm Deletion,class:thunderbird"
          "size 450 150,title:Confirm Deletion,class:thunderbird"
          "center 1,title:Confirm Deletion,class:thunderbird"

          # Office365 Sign-in Prompt
          "float,title:(Enter credentials for)(.*),class:thunderbird"
          "size 50% 50%,title:(Enter credentials for)(.*),class:thunderbird"
          "center 1,title:(Enter credentials for)(.*),class:thunderbird"

          # Delete Contact Confirmation
          "float,title:Delete Contact,class:thunderbird"
          "size 450 120,title:Delete Contact,class:thunderbird"
          "center 1,title:Delete Contact,class:thunderbird"

          # Delete Event Confirmation
          "float,title:Delete Event,class:thunderbird"
          "size 450 120,title:Delete Event,class:thunderbird"
          "center 1,title:Delete Event,class:thunderbird"

          # Delete Repeating Event Confirmation
          "float,title:Delete Repeating Event,class:thunderbird"
          "size 400 250,title:Delete Repeating Event,class:thunderbird"
          "center 1,title:Delete Repeating Event,class:thunderbird"

          # Remove Calendar Dialogue
          "float,title:Remove Calendar,class:thunderbird"
          "size 450 150,title:Remove Calendar,class:thunderbird"
          "center 1,title:Remove Calendar,class:thunderbird"

          # Save event dialogue
          "float,title:Save Event,class:thunderbird"
          "size 450 150,title:Save Event,class:thunderbird"
          "center 1,title:Save Event,class:thunderbird"
        ];
      })
    ]))
  ]);
}
