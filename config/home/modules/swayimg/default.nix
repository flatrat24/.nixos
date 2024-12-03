{ pkgs, ... }: {

  home.file = {
    ".config/swayimg/config" = {
      # text = ''
      #   ################################################################################
      #   # General options
      #   ################################################################################
      #   [general]
      #   mode = viewer
      #   app_id = swayimg
      #   
      #   ################################################################################
      #   # Viewer mode configuration
      #   ################################################################################
      #   [viewer]
      #   window = #FFFFFF00
      #   transparency = grid
      #   scale = optimal
      #   fixed = yes
      #   antialiasing = yes
      #   slideshow = no
      #   slideshow_time = 3
      #   history = 3
      #   preload = 1
      #   
      #   ################################################################################
      #   # Gallery mode configuration
      #   ################################################################################
      #   [gallery]
      #   size = 200
      #   cache = 100
      #   fill = yes
      #   antialiasing = no
      #   window = #28282800
      #   background = #282828ff
      #   select = #404040ff
      #   border = #000000ff
      #   shadow = #000000ff
      #   
      #   ################################################################################
      #   # Image list configuration
      #   ################################################################################
      #   [list]
      #   order = none
      #   loop = yes
      #   recursive = no
      #   all = yes
      #   
      #   ################################################################################
      #   # Font configuration
      #   ################################################################################
      #   [font]
      #   name = FiraCode Nerd Font Mono
      #   size = 12
      #   color = #F9F5D7FF
      #   shadow = #282828a0
      #   
      #   ################################################################################
      #   # Image meta info scheme (format, size, EXIF, etc)
      #   ################################################################################
      #   [info]
      #   show = no
      #   info_timeout = 0
      #   status_timeout = 3
      #   
      #   [info.viewer]
      #   top_left = +name,+format,+filesize,+imagesize,+exif
      #   top_right = index
      #   bottom_left = scale,frame
      #   bottom_right = status
      #   
      #   [info.gallery]
      #   top_left = none
      #   top_right = none
      #   bottom_left = none
      #   bottom_right = name,status
      #   
      #   ################################################################################
      #   # Viewer mode key binding configuration: key = action [parameters]
      #   ################################################################################
      #   [keys.viewer]
      #   Shift+/      = help
      #   Home         = first_file
      #   End          = last_file
      #   Shift+k      = prev_file
      #   Shift+j      = next_file
      #   Shift+h      = prev_dir
      #   Shift+l      = next_dir
      #   h            = step_left 5
      #   l            = step_right 5
      #   k            = step_up 5
      #   j            = step_down 5
      #   ,            = prev_frame
      #   .            = next_frame
      #   s            = slideshow
      #   a            = animation
      #   m            = mode
      #   Plus         = zoom fit
      #   Equal        = zoom +10
      #   Minus        = zoom -10
      #   w            = zoom width
      #   e            = zoom height
      #   0            = zoom real
      #   BackSpace    = zoom optimal
      #   r            = rotate_left
      #   Shift=r      = rotate_right
      #   v            = flip_vertical
      #   Shift+v      = flip_horizontal
      #   Shift+a      = antialiasing
      #   Shift+r      = reload
      #   i            = info
      #   Shift+Delete = exec rm "%"; skip_file
      #   q            = exit
      #   
      #   # Mouse related
      #   ScrollLeft       = step_right 5
      #   ScrollRight      = step_left 5
      #   ScrollUp         = step_up 5
      #   ScrollDown       = step_down 5
      #   Ctrl+ScrollUp    = zoom +10
      #   Ctrl+ScrollDown  = zoom -10
      #   Shift+ScrollUp   = prev_file
      #   Shift+ScrollDown = next_file
      #   Alt+ScrollUp     = prev_frame
      #   Alt+ScrollDown   = next_frame
      #   
      #   ################################################################################
      #   # Gallery mode key binding configuration: key = action [parameters]
      #   ################################################################################
      #   [keys.gallery]
      #   question     = help
      #   Home         = first_file
      #   End          = last_file
      #   h            = step_left
      #   l            = step_right
      #   k            = step_up
      #   j            = step_down
      #   PageUp       = page_up
      #   PageDown     = page_down
      #   c            = skip_file
      #   m            = mode
      #   Shift+a      = antialiasing
      #   Shift+r      = reload
      #   i            = info
      #   Shift+Delete = exec rm "%"; skip_file
      #   q            = exit
      #   
      #   # Mouse related
      #   ScrollLeft   = step_right
      #   ScrollRight  = step_left
      #   ScrollUp     = step_up
      #   ScrollDown   = step_down
      # '';
      text = ''
        ################################################################################
        # General options
        ################################################################################
        [general]
        scale = optimal
        fullscreen = no
        antialiasing = yes
        transparency = grid
        background = #282828
        slideshow = no
        slideshow_time = 3

        ################################################################################
        # Image list configuration
        ################################################################################
        [list]
        order = none
        loop = yes
        recursive = no
        all = yes

        ################################################################################
        # Font configuration
        ################################################################################
        [font]
        name = FiraCode Nerd Font Mono
        size = 12
        color = #F9F5D7
        shadow = #282828

        ################################################################################
        # Image meta info scheme (format, size, EXIF, etc)
        ################################################################################
        [info]
        mode = off
        full.topleft = name,format,filesize,imagesize,exif
        full.topright = index
        full.bottomleft = scale,frame
        full.bottomright = status
        brief.topleft = index
        brief.topright = none
        brief.bottomleft = none
        brief.bottomright = status

        ################################################################################
        # Key binding section: key = action [parameters]
        # Key can be specified with modifiers, e.g "Ctrl+Alt+Shift+x"
        # Use the `xkbcli` tool to get key name: `xkbcli interactive-wayland`
        ################################################################################
        [keys]
        question     = help
        Home         = first_file
        End          = last_file
        Shift+k      = prev_file
        Shift+j      = next_file
        Shift+h      = prev_dir
        Shift+l      = next_dir
        h            = step_left 5
        l            = step_right 5
        k            = step_up 5
        j            = step_down 5
        comma        = prev_frame
        period       = next_frame
        s            = slideshow
        a            = animation
        Plus         = zoom fit
        Equal        = zoom +10
        Minus        = zoom -10
        w            = zoom width
        e            = zoom height
        0            = zoom real
        BackSpace    = zoom optimal
        r            = rotate_left
        v            = flip_vertical
        Shift+v      = flip_horizontal
        Shift+a      = antialiasing
        Shift+r      = reload
        i            = info
        Shift+Delete = exec rm "%"; skip_file
        q            = exit

        ################################################################################
        # Mouse / touchpad configuration, same format as in [keys]
        ################################################################################
        [mouse]
        ScrollLeft       = step_right 5
        ScrollRight      = step_left 5
        ScrollUp         = step_up 5
        ScrollDown       = step_down 5
        Ctrl+ScrollUp    = zoom +10
        Ctrl+ScrollDown  = zoom -10
        Shift+ScrollUp   = prev_file
        Shift+ScrollDown = next_file
        Alt+ScrollUp     = prev_frame
        Alt+ScrollDown   = next_frame
      '';
      executable = true;
    };
  };

  home.packages = with pkgs; [
    swayimg
    libjpeg
    libjxl
    libpng
    giflib
    librsvg
    libwebp
    libheif
    libavif
    libtiff
    openexr
  ];

}
