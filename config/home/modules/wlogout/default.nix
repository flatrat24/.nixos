{ pkgs, lib, config, ... }:
let
  cfg = config.wlogout;
in {
  options = {
    wlogout.enable = lib.mkEnableOption "enables wlogout";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.file = {
        ".config/wlogout" = {
          source = ./sources;
          executable = false;
          recursive = true;
        };
      };

      programs.wlogout = {
        enable = true;
        layout = [
          {
            label = "lock";
            action = "hyprlock";
            text = "[L]ock";
            keybind = "L";
          }
          {
            label = "hibernate";
            action = "systemctl hibernate";
            text = "[H]ibernate";
            keybind = "H";
          }
          {
            label = "logout";
            action = "hyprctl dispatch exit";
            text = "lo[G]out";
            keybind = "G";
          }
          {
            label = "shutdown";
            action = "systemctl poweroff";
            text = "[S]hutdown";
            keybind = "S";
          }
          {
            label = "suspend";
            action = "systemctl suspend";
            text = "s[U]spend";
            keybind = "U";
          }
          {
            label = "reboot";
            action = "systemctl reboot";
            text = "[R]eboot";
            keybind = "R";
          }
        ];
        style = ''
          * {
            background-image: none;
            box-shadow: none;
          }

          window {
            background-color: rgba(30, 30, 46, 0.90);
          }

          button {
            border-radius: 0px;
            border-color: #CBA6F7;
            text-decoration-color: #CDD6F4;
            color: #CDD6F4;
            background-color: #181825;
            border-style: solid;
            border-width: 3px;
            background-repeat: no-repeat;
            background-position: center;
            background-size: 40%;
            margin: 5px;
          }


          button:focus, button:active, button:hover {
            /* 20% Overlay 2, 80% mantle */
            background-color: rgb(48, 50, 66);
            outline-style: none;
          }

          #lock {
            background-image: image(url("${pkgs.wleave}/share/wleave/icons/lock.svg")); 
          }

          #logout {
            background-image: image(url("${pkgs.wleave}/share/wleave/icons/logout.svg"));
          }

          #suspend {
            background-image: image(url("${pkgs.wleave}/share/wleave/icons/shutdown.svg"));
          }

          #hibernate {
            background-image: image(url("${pkgs.wleave}/share/wleave/icons/hibernate.svg"));
          }

          #shutdown {
            background-image: image(url("${pkgs.wleave}/share/wleave/icons/shutdown.svg"));
          }

          #reboot {
            background-image: image(url("${pkgs.wleave}/share/wleave/icons/reboot.svg"));
          }
        '';
      };
    }
    (lib.mkIf config.hyprland.enable {
      wayland.windowManager.hyprland.settings = {
        bindd = [
          "$mod, Escape, Lock Screen, exec, wlogout"
        ];
      };
    })
  ]);
}
