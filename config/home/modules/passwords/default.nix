{ pkgs, lib, config, ... }:
let
  cfg = config.passwords;
  wofipass = pkgs.writeShellApplication {
    name = "wofipass.sh";
    runtimeInputs = with pkgs; [
      fd
      wofi
    ];
    text = builtins.readFile ./sources/wofipass.sh;
  };
in {
  options = {
    passwords = {
      enable = lib.mkEnableOption "enables passwords";
      keepass.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      pass.enable = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    (lib.mkIf cfg.pass.enable (lib.mkMerge [
      {
        home.packages = with pkgs; [ passepartui ];

        programs = {
          password-store = {
            enable = true;
            package = pkgs.pass.withExtensions (exts: [exts.pass-import]);
            settings = {
              PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
            };
          };
          browserpass.enable = true;
        };
      }
      (lib.mkIf config.wofi.enable (lib.mkMerge [
        {
          home.packages = [
            pkgs.wtype
            wofipass
          ];
        }
        (lib.mkIf config.hyprland.enable {
          wayland.windowManager.hyprland.settings = {
            bindd = [
              "$mod, c, Wofi Pass, exec, wofipass.sh | wl-copy"
            ];
          };
        })
      ]))
    ]))
    (lib.mkIf cfg.keepass.enable (lib.mkMerge [
      {
        home.packages = with pkgs; [
          keepassxc
          keepassxc-go
          keepass-diff
        ];
      }
    ]))
  ]);
}
