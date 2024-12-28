{ pkgs, lib, config, ... }:
let
  cfg = config.foot;
  dependencies = with pkgs; [
    foot
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

            [cursor]
            color=11111b f5e0dc

            [colors]
            alpha=0.95
            foreground=cdd6f4
            background=1e1e2e

            regular0=45475a
            regular1=f38ba8
            regular2=a6e3a1
            regular3=f9e2af
            regular4=89b4fa
            regular5=f5c2e7
            regular6=94e2d5
            regular7=bac2de

            bright0=585b70
            bright1=f38ba8
            bright2=a6e3a1
            bright3=f9e2af
            bright4=89b4fa
            bright5=f5c2e7
            bright6=94e2d5
            bright7=a6adc8

            16=fab387
            17=f5e0dc

            selection-foreground=cdd6f4
            selection-background=414356

            search-box-no-match=11111b f38ba8
            search-box-match=cdd6f4 313244

            jump-labels=11111b fab387
            urls=89b4fa

            [mouse]
            hide-when-typing = yes

            [key-bindings]
            scrollback-up-page                          = Shift+Page_Up
            scrollback-up-half-page                     = Page_Up
            scrollback-up-line                          = Up
            scrollback-down-page                        = Shift+Page_Down
            scrollback-down-half-page                   = Page_Down
            scrollback-down-line                        = Down
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

      wayland.windowManager.hyprland.settings = {
        bindd = [
          "$mod, A, Launch Terminal, exec, foot"
        ];
      };
    }
    (lib.mkIf config.yazi.enable {
      programs.yazi.settings.opener = {
        directory = [
          { run = ''foot -D "$@"''; orphan = true; desc = " foot"; }
        ];
      };
    })
  ]);
}
