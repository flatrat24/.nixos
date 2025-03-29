{ pkgs, lib, config, ... }:
let
  cfg = config.zathura;
  dependencies = with pkgs; [
    zathura
  ];
in{
  options = {
    zathura.enable = lib.mkEnableOption "enables zathura";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;

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
          default-fg              = "rgba(205,214,244,1)";
          default-bg              = "rgba(30,30,46,1)";

          completion-bg           = "rgba(49,50,68,1)";
          completion-fg           = "rgba(205,214,244,1)";
          completion-highlight-bg = "rgba(87,82,104,1)";
          completion-highlight-fg = "rgba(205,214,244,1)";
          completion-group-bg     = "rgba(49,50,68,1)";
          completion-group-fg     = "rgba(137,180,250,1)";

          statusbar-fg            = "rgba(205,214,244,1)";
          statusbar-bg            = "rgba(49,50,68,1)";

          notification-bg         = "rgba(49,50,68,1)";
          notification-fg         = "rgba(205,214,244,1)";
          notification-error-bg   = "rgba(49,50,68,1)";
          notification-error-fg   = "rgba(243,139,168,1)";
          notification-warning-bg = "rgba(49,50,68,1)";
          notification-warning-fg = "rgba(250,227,176,1)";

          inputbar-fg             = "rgba(205,214,244,1)";
          inputbar-bg             = "rgba(49,50,68,1)";

          recolor                 = "false";
          recolor-lightcolor      = "rgba(30,30,46,1)";
          recolor-darkcolor       = "rgba(205,214,244,1)";

          index-fg                = "rgba(205,214,244,1)";
          index-bg                = "rgba(30,30,46,1)";
          index-active-fg         = "rgba(205,214,244,1)";
          index-active-bg         = "rgba(49,50,68,1)";

          render-loading-bg       = "rgba(30,30,46,1)";
          render-loading-fg       = "rgba(205,214,244,1)";

          highlight-color         = "rgba(17, 17, 27, 0.75)";
          highlight-fg            = "rgba(223, 142, 29, 0.75)";
          highlight-active-color  = "rgba(223, 142, 29, 0.75)";
          # highlight-active-color  = "rgba(245,194,231,0.5)";

          page-padding            = 3;
          font                    = "IBM Plex mono 10";

          selection-clipboard     = "clipboard";
        };
      };

      xdg = {
        enable = lib.mkDefault true;
        mimeApps.enable = lib.mkDefault true;
        mimeApps.defaultApplications = {
          "application/pdf" = ["org.pwmt.zathura.desktop"];
        };
      };
    }
    (lib.mkIf config.yazi.enable {
      programs.yazi.settings.opener = {
        pdf = [                                     
          { run = ''zathura "$@"''; orphan = true; desc = "󰯉 zathura"; }
        ];
      };
    })
    # (lib.mkIf config.theme.enable {
    #   stylix.targets = {
    #     zathura.enable = true;
    #   };
    # })
  ]);
}
