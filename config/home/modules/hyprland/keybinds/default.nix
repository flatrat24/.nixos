# l -> locked, will also work when an input inhibitor (e.g. a lockscreen) is active.
# r -> release, will trigger on release of a key.
# o -> longPress, will trigger on long press of a key.
# e -> repeat, will repeat when held.
# n -> non-consuming, key/mouse events will be passed to the active window in addition to triggering the dispatcher.
# m -> mouse, see below.
# t -> transparent, cannot be shadowed by other binds.
# i -> ignore mods, will ignore modifiers.
# s -> separate, will arbitrarily combine keys between each mod/key, see [Keysym combos](#keysym-combos) above.
# d -> has description, will allow you to write a description for your bind.
# p -> bypasses the app's requests to inhibit keybinds.

{ ... }:
let
  functionBinds = {
    bindm = [ ];
    binded = [
      ##--- Screenshots ---##
      '', F11, Screenshot (Select Area), exec, pkill hyprshot || hyprshot --mode region --output-folder ~/Downloads''
      ''$mod SHIFT, F11, Screenshot (Entire Screen), exec, pkill hyprshot || hyprshot --mode output --mode active --output-folder ~/Downloads''
    ];
    bindd = [
      ##--- Color Picker ---##
      ", F12, Activate Color Picker, exec, pkill hyprpicker || hyprpicker | wl-copy"
    ];
    bindld = [ ];
    bindeld = [
      ##--- Screenshots ---##
      ''$mod, F11, Screenshot (Focused Window), exec, pkill hyprshot || hyprshot --mode window --output-folder ~/Downloads''
    ];
  };
  xf86Binds = {
    bindm = [ ];
    binded = [
    ];
    bindd = [
      ##--- Window Focus (Sat75x Rotary Encoder) ---##
      ", XF86Tools, Focus Next Workspace (Sat75x Encoder), workspace, +1"
      ", XF86Launch5, Focus Previous Workspace (Sat75x Encoder), workspace, -1"
      ", XF86Launch6, Focus Most Recent Workspace (Sat75x Encoder), workspace, previous"
    ];
    bindld = [
      ##--- MPD Controls ---##
      ", XF86AudioNext, Play Next Song (MPD), exec, mpc next"
      ", XF86AudioPlay, Play/Pause Song (MPD), exec, mpc toggle"
      ", XF86AudioPrev, Play Previous Song (MPD), exec, mpc prev"
    ];
    bindeld = [
      ##--- Volume Controls ---##
      ", XF86AudioMute, Toggle Volume Mute, exec, pamixer -t"
      ", XF86AudioLowerVolume, Decrease Volume, exec, pamixer -d 2"
      ", XF86AudioRaiseVolume, Increase Volume, exec, pamixer -i 2"

      ##--- Brightness ---##
      ", XF86MonBrightnessUp, Decrease Screen Brightness, exec, brightnessctl s +2%"
      ", XF86MonBrightnessDown, Increase Screen Brightness, exec, brightnessctl s 2%-"
    ];
  };
  otherBinds = {
    bindm = [
      ##--- Manage Windows With Mouse ---##
      ", mouse:274, movewindow"
      "$mod, mouse:272, movewindow"
      "$mod SHIFT, mouse:272, resizewindow"
      "$mod, ALT_l, movewindow"
      "$mod SHIFT, ALT_l, resizewindow"
    ];
    binded = [
      ##--- Resize Focused Window ---##
      "$mod SHIFT CTRL, H, Resize Window Leftwards, resizeactive, -40 0"
      "$mod SHIFT CTRL, L, Resize Window Rightwards, resizeactive, 40 0"
      "$mod SHIFT CTRL, K, Resize Window Upwards, resizeactive, 0 -40"
      "$mod SHIFT CTRL, J, Resize Window Downwards, resizeactive, 0 40"

      "$mod, equal, Focus Next Workspace, workspace, +1"
      "$mod, minus, Focus Previous Workspace, workspace, -1"

      "$mod SHIFT, equal, Move Window to Next Workspace, movetoworkspace, r+1"
      "$mod SHIFT, minus, Move Window to Previous Workspace, movetoworkspace, r-1"

      ##--- Tab Stacking ---##
      "$mod CTRL, L, Focus Next Window in Stack, changegroupactive, f"
      "$mod CTRL, H, Focus Previous Window in Stack, changegroupactive, b"

      ##--- Window Focus ---##
      "$mod, h, Focus Left Window, movefocus, l"
      "$mod, l, Focus Right Window, movefocus, r"
      "$mod, k, Focus Upper Window, movefocus, u"
      "$mod, j, Focus Lower Window, movefocus, d"
      "$mod, Tab, Cycle Window Focus, cyclenext, "
      "$mod, Tab,, bringactivetotop, "

      ##--- Manage Monitors ---##
      "$mod CTRL, equal, Focus Next Monitor, focusmonitor, +1"
      "$mod CTRL, minus, Focus Previous Monitor, focusmonitor, -1"
      "$mod SHIFT CTRL, equal, Move Workspace to Next Monitor, movecurrentworkspacetomonitor, +1"
      "$mod SHIFT CTRL, minus, Move Workspace to Next Monitor, movecurrentworkspacetomonitor, -1"

      ##--- Workspace Focus ---##
      "$mod, BackSpace, Focus Most Recent Workspace, workspace, previous"
      "$mod SHIFT, BackSpace, Move Window to Most Recent Workspace, movetoworkspace, previous"
    ];
    bindd = [
      ##--- General Window Controls ---##
      "$mod, Q, Kill Active Window, killactive, null"
      "$mod, O, Toggle Floating Window, togglefloating,"
      "$mod, P, Toggle Fullscreen Window, fullscreen,"
      "$mod, U, Cycle Left and Bottom Layout, layoutmsg, orientationcycle left top"

      ##--- Tab Stacking ---##
      "$mod, I, Toggle Window Stacking, togglegroup,"

      ##--- Moving Windows Within a Workspace ---##
      "$mod SHIFT, H, Move Window Left, movewindoworgroup, l"
      "$mod SHIFT, L, Move Window Right, movewindoworgroup, r"
      "$mod SHIFT, K, Move Window Up, movewindoworgroup, u"
      "$mod SHIFT, J, Move Window Down, movewindoworgroup, d"

      ##--- Hyprexpo ---##
      # "$mod, A, hyprexpo:expo, toggle"

      ##--- Workspace Focus ---##
      "$mod, 1, Focus Workspace 1,  split:workspace, 1"
      "$mod, 2, Focus Workspace 2,  split:workspace, 2"
      "$mod, 3, Focus Workspace 3,  split:workspace, 3"
      "$mod, 4, Focus Workspace 4,  split:workspace, 4"
      "$mod, 5, Focus Workspace 5,  split:workspace, 5"
      "$mod, 6, Focus Workspace 6,  split:workspace, 6"
      "$mod, 7, Focus Workspace 7,  split:workspace, 7"
      "$mod, 8, Focus Workspace 8,  split:workspace, 8"
      "$mod, 9, Focus Workspace 9,  split:workspace, 9"
      "$mod, 0, Focus Workspace 10, split:workspace, 10"

      ##--- Move Windows Between Workspaces ---##
      "$mod SHIFT, 1, Move Window to Workspace 1, split:movetoworkspace, 0"
      "$mod SHIFT, 2, Move Window to Workspace 2, split:movetoworkspace, 2"
      "$mod SHIFT, 3, Move Window to Workspace 3, split:movetoworkspace, 3"
      "$mod SHIFT, 4, Move Window to Workspace 4, split:movetoworkspace, 4"
      "$mod SHIFT, 5, Move Window to Workspace 5, split:movetoworkspace, 5"
      "$mod SHIFT, 6, Move Window to Workspace 6, split:movetoworkspace, 6"
      "$mod SHIFT, 7, Move Window to Workspace 7, split:movetoworkspace, 7"
      "$mod SHIFT, 8, Move Window to Workspace 8, split:movetoworkspace, 8"
      "$mod SHIFT, 9, Move Window to Workspace 9, split:movetoworkspace, 9"
      "$mod SHIFT, 0, Move Window to Workspace 10, split:movetoworkspace, 10"
      "$mod SHIFT, BackSpace, Move Window to Recent Workspace, split:movetoworkspace, previous"

      ##--- Other Workspace Stuff ---##
      "$mod , G, Grab Rogue Windows, split:grabroguewindows"
    ];
    bindld = [ ];
    bindeld = [ ];
  };
in {

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    unbind = [
      ",XF86RFKill"
      ",Print"
      ",XF86AudioMedia"
    ];

    bindm = functionBinds.bindm ++ xf86Binds.bindm ++ otherBinds.bindm;
    binded = functionBinds.binded ++ xf86Binds.binded ++ otherBinds.binded;
    bindd = functionBinds.bindd ++ xf86Binds.bindd ++ otherBinds.bindd;
    bindld = functionBinds.bindld ++ xf86Binds.bindld ++ otherBinds.bindld;
    bindeld = functionBinds.bindeld ++ xf86Binds.bindeld ++ otherBinds.bindeld;
  };
}
