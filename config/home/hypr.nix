{ inputs, pkgs, ... }: {

  # home.file = {
  #   ".config/hypr" = {
  #     source = ./sources/hypr;
  #     executable = false;
  #     recursive = true;
  #   };
  # };

  # home.file = {
  #   ".config/waybar" = {
  #     source = ./sources/waybar;
  #     executable = false;
  #     recursive = true;
  #   };
  # };

  # imports = [ inputs.ags.homeManagerModules.default ];
  # programs.ags = {
  #   enable = true;
  #   extraPackages = with pkgs; [
  #     gtksourceview
  #     webkitgtk
  #     accountsservice
  #   ];
  # };

  # home.file = {
  #   ".config/mako/config" = {
  #     source = ./sources/mako/config;
  #     executable = false;
  #     recursive = false;
  #   };
  # };

  #### HYPRLAND TRANSFORMATION ####
  # Main Settings
  programs.kitty.enable = true;
  wayland.windowManager.hyprland.enable = true;

  # Theme
  wayland.windowManager.hyprland.settings = {
    # COLORS #
    "$cursor" = "rgba(928374ee)";

    "$url_color" = "rgba(83a598ee)";

    "$visual_bell_color" = "rgba(8ec07cee)";
    "$bell_border_color" = "rgba(8ec07cee)";

    "$active_border_color" = "rgba(d3869bee)";
    "$inactive_border_color" = "rgba(665c54ee)";

    "$foreground" = "rgba(ebdbb2ee)";
    "$background" = "rgba(282828ee)";
    "$selection_foreground" = "rgba(928374ee)";
    "$selection_background" = "rgba(ebdbb2ee)";

    "$active_tab_foreground" = "rgba(fbf1c7ee)";
    "$active_tab_background" = "rgba(665c54ee)";
    "$inactive_tab_foreground" = "rgba(a89984ee)";
    "$inactive_tab_background" = "rgba(3c3836ee)";

    # black  (bg3/bg4)
    "$color0" = "rgba(665c54ee)";
    "$color8" = "rgba(7c6f64ee)";

    # red
    "$color1" = "rgba(cc241dee)";
    "$color9" = "rgba(fb4934ee)";

    # green
    "$color2" = "rgba(98971aee)";
    "$color10" = "rgba(b8bb26ee)";

    # yellow
    "$color3" = "rgba(d79921ee)";
    "$color11" = "rgba(fabd2fee)";

    # blue
    "$color4" = "rgba(458588ee)";
    "$color12" = "rgba(83a598ee)";

    # purple
    "$color5" = "rgba(b16286ee)";
    "$color13" = "rgba(d3869bee)";

    # aqua
    "$color6" = "rgba(689d6aee)";
    "$color14" = "rgba(8ec07cee)";

    # white (fg4/fg3)
    "$color7" = "rgba(a89984ee)";
    "$color15" = "rgba(bdae93ee)";

    "$mod" = "SUPER";
    "$terminal" = "foot";
    bindd = [
      "$mod, Escape, Lock Screen, exec, hyprlock"
      "$mod, A, Launch Terminal, exec, $terminal"
    ];

    general = {
      "gaps_in" = "5";
      "gaps_out" = "5";
      "border_size" = "3";
      "col.active_border" = "$color11";
      "col.inactive_border" = "$color2";
      "resize_on_border" = "true" ;
      "allow_tearing" = "false";
      "layout" = "master";
    };

    decoration = {
      "rounding" = "0";
      "active_opacity" = "1.0";
      "inactive_opacity" = "1.0";
      "drop_shadow" = "true";
      "shadow_range" = "4";
      "shadow_render_power" = "3";
      "col.shadow" = "rgba(1a1a1aee)";
      "blur" = {
        "enabled" = "true";
        "size" = "3";
        "passes" = "1";
        "vibrancy" = "0.1696";
      };
    };

    # animations = {
    #   "enabled" = "true";
    #   "bezier" = "myBezier, 0.05, 0.9, 0.1, 1.05";
    #   "animation" = "windows, 1, 2, myBezier, slidein";
    #   "animation" = "border, 1, 2, default";
    #   "animation" = "fade, 1, 2, default";
    #   "animation" = "workspaces, 1, 2, default, slide";
    # };

    dwindle = {
      "pseudotile" = "true";
      "preserve_split" = "true";
    };

    master = {
      "new_status" = "slave";
    };

    misc = {
      "force_default_wallpaper" = "-1";
      "disable_hyprland_logo" = "true";
    };

    group = {
      "col.border_active" = "$color11";
      "col.border_inactive" = "$color2";
      "col.border_locked_active" = "$color11";
      "col.border_locked_inactive" = "$color2";
      groupbar = {
        "enabled" = "true";
        "font_size" = "10";
        "font_family" = "Fira Code Nerd Font Mono";
        "height" = "14";
        "render_titles" = "true";
        "text_color" = "$background";
        "col.active" = "$color10";
        "col.inactive" = "$color2";
        "col.locked_active" = "$color10";
        "col.locked_inactive" = "$color2";
      };
    };
  };

  # Hyprpaper
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "/home/ea/.dotfiles/config/home/sources/hypr/assets/grove.png"
      ];
      wallpaper = [
        ",/home/ea/.dotfiles/config/home/sources/hypr/assets/grove.png"
      ];
    };
  };

  # Hyprlock
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
        path = "/home/ea/.dotfiles/config/home/sources/hypr/assets/grove.png";
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
        font_size = 30;
        font_family = "Fira Code Nerd Font Mono";
        position = "0, -60";
        halign = "center";
        valign = "top";
      } {
        # Current Time
        monitor = "";
        text = ''cmd[update:1000] echo "$(date +'%H:%M')"'';
        color = "rgba(250, 189, 47, .75)";
        font_size = 120;
        font_family = "MesloLGS NF";
        position = "0, -90";
        halign = "center";
        valign = "top";
      } {
        # Song Info
        monitor = "";
        text = "cmd[update:1000] echo $(/home/ea/.dotfiles/config/home/sources/hypr/scripts/songDetails.sh)";
        color = "rgba(235, 219, 178, .75)";
        font_size = 16;
        font_family = "Fira Code Nerd Font Mono";
        position = "0, 50";
        halign = "center";
        valign = "bottom";
      }];

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
        font_family = "Fira Code Nerd Font Mono";
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

  home.packages = with pkgs; [
    hyprland
    hyprshot
    hyprlock
    hyprlang
    hypridle
    hyprpaper
    hyprpicker
    hyprcursor
    xdg-desktop-portal-hyprland
    cliphist
    wl-clipboard
    wl-clip-persist
    grimblast
    mako
    libnotify
    rofi-wayland
    # waybar
    pamixer
    brightnessctl
    wev
    foot
    meslo-lgs-nf
    fira-code-nerdfont
    kitty
  ];

  home.sessionVariables = {
    BOOKMARKS = "/home/ea/Documents/Personal/bookmarks.json";
  };

}
