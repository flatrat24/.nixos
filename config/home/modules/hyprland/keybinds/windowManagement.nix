{ pkgs, lib, inputs, config, ... }: {
  options = {};

  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland.settings = {
      bindd = [
        ##### General Window Controls #####
        "$mod, Q, Kill Active Window, killactive, null"
        "$mod, P, Toggle Floating Window, togglefloating,"
        "$mod, O, Toggle Fullscreen Window, fullscreen,"
        "$mod, U, Cycle Left and Bottom Layout, layoutmsg, orientationcycle left top"

        ##### Window Focus #####
        "$mod, h, Focus Left Window, movefocus, l"
        "$mod, l, Focus Right Window, movefocus, r"
        "$mod, k, Focus Upper Window, movefocus, u"
        "$mod, j, Focus Lower Window, movefocus, d"
        "$mod, Tab, Cycle Window Focus, cyclenext, "
        "$mod, Tab,, bringactivetotop, "

        ##### Tab Stacking #####
        "$mod, I, Toggle Window Stacking, togglegroup,"
        "$mod CTRL, L, Focus Next Window in Stack, changegroupactive, f"
        "$mod CTRL, H, Focus Previous Window in Stack, changegroupactive, b"

        ##### Moving Windows Within a Workspace #####
        "$mod SHIFT, H, Move Window Left, movewindoworgroup, l"
        "$mod SHIFT, L, Move Window Right, movewindoworgroup, r"
        "$mod SHIFT, K, Move Window Up, movewindoworgroup, u"
        "$mod SHIFT, J, Move Window Down, movewindoworgroup, d"

        ##### Workspace Focus #####
        "$mod, 1, Focus Workspace 1, workspace, 1"
        "$mod, 2, Focus Workspace 2, workspace, 2"
        "$mod, 3, Focus Workspace 3, workspace, 3"
        "$mod, 4, Focus Workspace 4, workspace, 4"
        "$mod, 5, Focus Workspace 5, workspace, 5"
        "$mod, 6, Focus Workspace 6, workspace, 6"
        "$mod, 7, Focus Workspace 7, workspace, 7"
        "$mod, 8, Focus Workspace 8, workspace, 8"
        "$mod, 9, Focus Workspace 9, workspace, 9"
        "$mod, 0, Focus Workspace 10, workspace, 10"
        "$mod, BackSpace, Focus Most Recent Workspace, workspace, previous"

        ##### Move Windows Between Workspaces #####
        "$mod SHIFT, 1, Move Window to Workspace 1, movetoworkspace, 0"
        "$mod SHIFT, 2, Move Window to Workspace 2, movetoworkspace, 2"
        "$mod SHIFT, 3, Move Window to Workspace 3, movetoworkspace, 3"
        "$mod SHIFT, 4, Move Window to Workspace 4, movetoworkspace, 4"
        "$mod SHIFT, 5, Move Window to Workspace 5, movetoworkspace, 5"
        "$mod SHIFT, 6, Move Window to Workspace 6, movetoworkspace, 6"
        "$mod SHIFT, 7, Move Window to Workspace 7, movetoworkspace, 7"
        "$mod SHIFT, 8, Move Window to Workspace 8, movetoworkspace, 8"
        "$mod SHIFT, 9, Move Window to Workspace 9, movetoworkspace, 9"
        "$mod SHIFT, 0, Move Window to Workspace 10, movetoworkspace, 10"
        "$mod SHIFT, BackSpace, Move Window to Recent Workspace, movetoworkspace, previous"
      ];
      binded = [
        ##### Resize Focused Window #####
        "$mod SHIFT CTRL, H, Resize Window Leftwards, resizeactive, -40 0"
        "$mod SHIFT CTRL, L, Resize Window Rightwards, resizeactive, 40 0"
        "$mod SHIFT CTRL, K, Resize Window Upwards, resizeactive, 0 -40"
        "$mod SHIFT CTRL, J, Resize Window Downwards, resizeactive, 0 40"

        "$mod, equal, Focus Next Workspace, workspace, +1"
        "$mod, minus, Focus Previous Workspace, workspace, -1"

        "$mod SHIFT, equal, Move Window to Next Workspace, movetoworkspace, r+1"
        "$mod SHIFT, minus, Move Window to Previous Workspace, movetoworkspace, r-1"

        ##### Manage Monitors #####
        "$mod SHIFT, equal, Focus Next Monitor, focusmonitor, +1"
        "$mod SHIFT, minus, Focus Previous Monitor, focusmonitor, -1"
        "$mod SHIFT CTRL, equal, Move Workspace to Next Monitor, movecurrentworkspacetomonitor, +1"
        "$mod SHIFT CTRL, minus, Move Workspace to Next Monitor, movecurrentworkspacetomonitor, -1"
      ];
      bindm = [
        ##### Manage Windows With Mouse #####
        "$mod, mouse:272, movewindow"
        "$mod SHIFT, mouse:272, resizewindow"
        "$mod, ALT_l, movewindow"
        "$mod SHIFT, ALT_l, resizewindow"
        ];
    };
  };
}
