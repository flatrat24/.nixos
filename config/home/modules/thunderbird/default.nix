{ lib, config, ... }:
let
  cfg = config.thunderbird;
  dependencies = [ ];
in {
  imports = [ ];

  options = {
    thunderbird.enable = lib.mkEnableOption "enable thunderbird";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
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
        # Compose Email Window
        "float,title:(Write: )(.*),class:thunderbird"
        "size 90% 90%,title:(Write: )(.*),class:thunderbird"
        "center 1,title:(Write: )(.*),class:thunderbird"

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
        "float,title:Select Calendar,class:thunderbird"
        "size 20% 30%,title:Select Calendar,class:thunderbird"
        "center 1,title:Select Calendar,class:thunderbird"

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

        # Link Confirmation Detections
        "float,title:Link Mismatch Detected,class:thunderbird"
        "size 50% 20%,title:Link Mismatch Detected,class:thunderbird"
        "center 1,title:Link Mismatch Detected,class:thunderbird"

        # Save event dialogue
        "float,title:Save Event,class:thunderbird"
        "size 450 150,title:Save Event,class:thunderbird"
        "center 1,title:Save Event,class:thunderbird"
      ];
    })
  ]);
}
