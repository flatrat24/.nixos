{ pkgs, ... }: {
  programs.zathura = {
    enable = true;
    mappings = {
      "d"      = "toggle_page_mode";
      "s"      = "adjust_window width";
      "a"      = "adjust_window best-fit";
      "r"      = "rotate";
      "return" = "snap_to_page";
      "R"      = "reload";
      "="      = "zoom in";
      "-"      = "zoom out";
      "+"      = "zoom default";
      "i"      = "recolor";
      "p"      = "print";
    };
    options = {
      notification-error-bg   = "rgba(40,40,40,1)";       # bg
      notification-error-fg   = "rgba(251,73,52,1)";      # bright:red
      notification-warning-bg = "rgba(40,40,40,1)";       # bg
      notification-warning-fg = "rgba(250,189,47,1)";     # bright:yellow
      notification-bg         = "rgba(40,40,40,1)";       # bg
      notification-fg         = "rgba(184,187,38,1)";     # bright:green

      completion-bg           = "rgba(80,73,69,1)";       # bg2
      completion-fg           = "rgba(235,219,178,1)";    # fg
      completion-group-bg     = "rgba(60,56,54,1)";       # bg1
      completion-group-fg     = "rgba(146,131,116,1)";    # gray
      completion-highlight-bg = "rgba(131,165,152,1)";    # bright:blue
      completion-highlight-fg = "rgba(80,73,69,1)";       # bg2

      index-bg                = "rgba(80,73,69,1)";       # bg2
      index-fg                = "rgba(235,219,178,1)";    # fg
      index-active-bg         = "rgba(131,165,152,1)";    # bright:blue
      index-active-fg         = "rgba(80,73,69,1)";       # bg2

      inputbar-bg             = "rgba(40,40,40,1)";       # bg
      inputbar-fg             = "rgba(235,219,178,1)";    # fg

      statusbar-bg            = "rgba(80,73,69,1)";       # bg2
      statusbar-fg            = "rgba(235,219,178,1)";    # fg

      highlight-color         = "rgba(250,189,47,0.75)";  # bright:yellow
      highlight-active-color  = "rgba(254,128,25,0.75)";  # bright:orange

      default-bg              = "rgba(40,40,40,1)";       # bg
      default-fg              = "rgba(235,219,178,1)";    # fg
      render-loading          = true;
      render-loading-bg       = "rgba(40,40,40,1)";       # bg
      render-loading-fg       = "rgba(235,219,178,1)";    # fg

      recolor-lightcolor      = "rgba(40,40,40,1)";       # bg
      recolor-darkcolor       = "rgba(235,219,178,1)";    # fg
      recolor                 = false;
      recolor-keephue         = true;                     # keep original color

      page-padding            = 3;
      font                    = "fira code nerd font mono 12";

      selection-clipboard     = "clipboard";
    };
  };

  xdg.desktopEntries = {
    zathura = {
      name = "Zathura";
      genericName = "Document Viewer";
      exec = "zathura %f";
      terminal = false;
      categories = [ "Office" "Viewer" ];
      mimeType = [ "application/pdf" ];
    };
  };

  home.packages = with pkgs; [
    zathura
  ];

}
