{ pkgs, lib, config, ... }:
let
  cfg = config.zed;
in {
  imports = [ ];

  options = {
    zed = {
      enable = lib.mkEnableOption "enables zed";
    };
  };


  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs = {
        zed-editor = {
          enable = true;
          extensions = [
            "catppuccin"
          ];
          userSettings = {
            theme = "catppuccin";
            features = {
              copilot = false;
            };
            telemetry = {
              metrics = false;
            };
            vim_mode = true;
            ui_font_size = 16;
            buffer_font_size = 16;
          };
        };
      };
    }
    (lib.mkIf config.yazi.enable {
      programs.yazi.settings.opener = {
        edit = lib.mkAfter [
          { run = ''zeditor "$@"''; block = true; desc = " zed"; }
        ];
        directory = lib.mkAfter [
          { run = ''zeditor "$@"''; block = true; desc = " zed"; }
        ];
      };
    })
  ]);
}
