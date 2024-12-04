{ pkgs, lib, inputs, config, ... }:
let
  dependencies = with pkgs; [
    ibm-plex
    hyprlock
  ];
in {
  options = {
    hypr.hyprlock = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.hypr.enable;
      };
      showMusic = lib.mkOption {
        type = lib.types.bool;
        default = config.mpd.enable;
      };
      # add topbar option to show things like wifi, bluetooth, etc
    };
  };

  config = lib.mkIf config.hypr.hyprlock.enable {
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
          path = "/home/ea/.nixos/config/home/modules/hypr/sources/assets/grove.png";
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
          color = "rgba(225, 225, 225, 0.75)";
          font_size = 25;
          font_family = "IBM Plex Sans";
          position = "0, -75";
          halign = "center";
          valign = "top";
        } {
          # Current Time
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +'%H:%M')"'';
          color = "rgba(250, 189, 47, .75)";
          font_size = 125;
          font_family = "IBM Plex Sans";
          position = "0, -100";
          halign = "center";
          valign = "top";
        }] ++ (if (config.mpd.enable == true) then [ # Remember to change mpd to music when making the change
          {
            monitor = "";
            text = "cmd[update:1000] echo $(/home/ea/.nixos/config/home/modules/hypr/sources/scripts/songDetails.sh)";
            color = "rgba(235, 219, 178, .75)";
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
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(150, 150, 150, 0.35)";
          font_color = "rgb(200, 200, 200)";

          dots_size = 0.38; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;

          fade_on_empty = false;
          font_family = "IBM Plex Sans";
          placeholder_text = "";

          check_color = "rgba(60, 56, 54, 0.5)";

          fail_color = "rgba(204, 36, 29, 0.75)";
          fail_text = "";
          fail_timeout = 2000;
          fail_transition = 300;

          capslock_color = "rgba(250, 189, 47, 0.35)";
          numlock_color = -1;
          bothlock_color = -1;

          size = "290, 30";
          hide_input = false;
          position = "0, 0";
          halign = "center";
          valign = "center";
        }];
      };
    };
  };
}
