# Kinda works, but I don't fully know
# I still need to get:
#   - KeepassXC database imported
#   - Initialized as a git repository (i think is safe with gpg)
#   - Reliably duplicated on multiple machines
#     - GPG duplicated
#     - Synced with Git (not with syncthing)

{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [ ];
in {
  options = {
    passwords = {
      pass.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = lib.mkIf config.passwords.pass.enable (lib.mkMerge [
    {
      home.packages = dependencies;

      programs = {
        password-store = {
          enable = true;
          package = pkgs.pass.withExtensions (exts: [exts.pass-import]);
          settings = {
            PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
          };
        };
      };
    }
    (lib.mkIf config.wofi.enable {
      home.packages = with pkgs; [
        wofi-pass
        wtype
      ];

      home.file = {
        ".config/wofi-pass/config" = {
          source = ./sources/config;
          executable = false;
          recursive = false;
        };
      };
    })
  ]);
}
