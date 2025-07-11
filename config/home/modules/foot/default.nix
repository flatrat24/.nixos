{ pkgs, lib, config, ... }:
let
  cfg = config.foot;
  dependencies = with pkgs; [
    foot
    libsixel
    (nerdfonts.override { fonts = [ "IBMPlexMono" ]; })
  ];
in {
  options = {
    foot.enable = lib.mkEnableOption "enables foot";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.file = {
        ".config/foot/foot.ini" = {
          text = ''
            title=terminal

            font                                    =IBM Plex Mono:size=12
            font-bold                               =IBM Plex Mono:style=Bold:size=12
            font-italic                             =IBM Plex Mono:style=Italic:size=12
            font-bold-italic                        =IBM Plex Mono:style=Bold:style=Italic:size=12
            font-size-adjustment                    =0.5

            pad=5x5 center

            [cursor]
            color=37f499 11111b

            [colors]
            alpha=1.00
            foreground=ebfafa
            background=212337

            regular0=21222c
            regular1=f9515d
            regular2=37f499
            regular3=e9f941
            regular4=9071f4
            regular5=f265b5
            regular6=04d1f9
            regular7=ebfafa

            bright0=7081d0
            bright1=f16c75
            bright2=69F8B3
            bright3=f1fc79
            bright4=a48cf2
            bright5=FD92CE
            bright6=66e4fd
            bright7=ffffff

            [mouse]
            hide-when-typing = yes

            [key-bindings]
            scrollback-up-page                          = Shift+Page_Up
            scrollback-up-half-page                     = Page_Up
            # scrollback-up-line                          = Up
            scrollback-down-page                        = Shift+Page_Down
            scrollback-down-half-page                   = Page_Down
            # scrollback-down-line                        = Down
            scrollback-home                             = none
            scrollback-end                              = none
            clipboard-copy                              = Control+Shift+c XF86Copy
            clipboard-paste                             = Control+Shift+v XF86Paste
            primary-paste                               = Shift+Insert
            search-start                                = Control+Shift+r
            font-increase                               = Control+equal Control+KP_Equal
            font-decrease                               = Control+minus Control+KP_Subtract
            font-reset                                  = Control+plus Control+KP_Add
            spawn-terminal                              = Control+Shift+n
            minimize                                    = none
            maximize                                    = none
            fullscreen                                  = none
            pipe-visible                                = [sh -c "xurls | fuzzel | xargs -r firefox"] none
            pipe-scrollback                             = [sh -c "xurls | fuzzel | xargs -r firefox"] none
            pipe-selected                               = [xargs -r firefox] none
            pipe-command-output                         = [wl-copy] none # Copy last command's output to the clipboard
            show-urls-launch                            = Control+Shift+o
            show-urls-copy                              = none
            show-urls-persistent                        = none
            prompt-prev                                 = Control+Shift+z
            prompt-next                                 = Control+Shift+x
            unicode-input                               = Control+Shift+u
            noop                                        = none
          '';
          executable = false;
        };
      };

      home.packages = dependencies;
    }
    (lib.mkIf config.hyprland.enable {
      wayland.windowManager.hyprland.settings = {
        bindd = [                                
          "$mod, A, Launch Terminal, exec, foot" 
          "$mod SHIFT, A, Launch Terminal with Zellij, exec, foot -e zellij" 
        ];                                       
        windowrulev2 = [
          "opacity 1.00 1.00 1.00 override 1.00 1.00 1.00 override,initialClass:foot,initialTitle:terminal"
        ];
      };
    })
    (lib.mkIf config.yazi.enable {
      programs.yazi.settings.opener = {
        directory = lib.mkBefore [
          { run = ''foot -D "$@"''; orphan = true; desc = " foot"; }
        ];
      };
    })
  ]);
}
