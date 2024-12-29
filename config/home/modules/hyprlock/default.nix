{ pkgs, lib, inputs, config, ... }:
let
  dependencies = with pkgs; [
    ibm-plex
    hyprlock
  ] ++ [ songDetails ];
  songDetails = pkgs.writeShellApplication {
    name = "songDetails.sh";
    runtimeInputs = with pkgs; [
      mpc-cli
    ];
    text = builtins.readFile ./sources/songDetails.sh;
  };
in {
  options = {
    hyprlock = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.hyprland.enable;
      };
      showMusic = lib.mkOption {
        type = lib.types.bool;
        default = config.mpd.enable;
      };
      # add topbar option to show things like wifi, bluetooth, etc
    };
  };

  config = lib.mkIf config.hyprlock.enable {
    home.packages = dependencies;
    
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          no_fade_in = false;
          grace = 0;
          disable_loading_bar = false;
        };

        background = [{
          monitor = "";
          path = "/home/ea/.assets/mountains.png";
          blur_passes = 3;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }];

        label = [{
          # Current Date
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date '+%A, %d %b')</span>"'';
          color = "rgba(205, 214, 244, 0.75)";
          font_size = 50; # Was 25 before double for framework
          font_family = "IBM Plex Sans";
          position = "0, -75";
          halign = "center";
          valign = "top";
        } {
          # Current Time
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +'%H:%M')"'';
          color = "rgba(250, 179, 135, .75)";
          font_size = 250; # Was 125 before double for framework
          font_family = "IBM Plex Sans";
          position = "0, -100";
          halign = "center";
          valign = "top";
        } {

        } ] ++ (if (config.music.mpd.enable == true) then [ # Make more options for different types of music if necessary. ALternatively, modify the script so it can dynamically find the name of the song regardless of the service through which the music is being played.
          {
            # MPD Song Status
            monitor = "";
            text = "cmd[update:1000] songDetails.sh";
            color = "rgba(255, 255, 255, .75)";
            font_size = 20;
            font_family = "IBM Plex Sans";
            position = "0, 50";
            halign = "center";
            valign = "bottom";
          }
        ] else [  ]);

        input-field = [{
          monitor = "";
          rounding = -0.5;
          outline_thickness = 0;
          outer_color = "rgba(30, 30, 46, 0)";
          inner_color = "rgba(49, 50, 58, 0.35)";
          font_color = "rgb(205, 214, 244)";

          dots_size = 0.38; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;

          fade_on_empty = false;
          font_family = "IBM Plex Sans";
          placeholder_text = "";

          check_color = "rgba(60, 56, 54, 0.5)";

          fail_color = "rgba(243, 139, 168, 0.75)";
          fail_text = "";
          fail_timeout = 2000;
          fail_transition = 300;

          capslock_color = "rgba(249, 226, 175, 0.35)";
          numlock_color = -1;
          bothlock_color = -1;

          size = "580, 60"; # Was 290, 30 before double for framework
          hide_input = false;
          position = "0, 0";
          halign = "center";
          valign = "center";
        }];
      };
    };

    wayland.windowManager.hyprland.settings = {
      bindd = [
        "$mod, Escape, Lock Screen, exec, hyprlock"
      ];
    };
  };
}
