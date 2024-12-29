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
        edit = [
          { run = ''zed "$@"''; block = true; desc = " zed"; }
        ];
        directory = [
          { run = ''zed "$@"''; block = true; desc = " zed"; }
        ];
      };
    })
  ]);
}
