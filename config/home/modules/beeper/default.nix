{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.beeper;
  beeper = import ../../../../derivations/beeper.nix { inherit pkgs; };
  dependencies = [
    beeper
  ];
in {
  options = {
    beeper.enable = lib.mkEnableOption "enable beeper";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
    (lib.mkIf config.hyprland.enable {
      wayland.windowManager.hyprland = {
        settings = {
          "exec-once" = [
            "[workspace 9 silent] beepertexts"
          ];
          windowrulev2 = [
            "group set,title:Beeper,class:Beeper"
          ];
        };
      };
    })
  ]);
}

# { pkgs, lib, inputs, config, ... }:
# let
#   pkgs = import (builtins.fetchGit {
#     # Descriptive name to make the store path easier to identify
#     name = "my-old-revision";
#     url = "https://github.com/NixOS/nixpkgs/";
#     ref = "refs/heads/nixos-24.05";
#     rev = "5a83f6f984f387d47373f6f0c43b97a64e7755c0";
#   }) {};
#   myPkg = pkgs.beeper;
#   cfg = config.beeper;
#   dependencies = [ myPkg ];
# in {
#   options = {
#     beeper.enable = lib.mkEnableOption "enable beeper";
#   };
#
#   config = lib.mkIf cfg.enable (lib.mkMerge [
#     {
#       home.packages = dependencies;
#     }
#     (lib.mkIf config.hyprland.enable {
#       wayland.windowManager.hyprland = {
#         settings = {
#           "exec-once" = [
#             "[workspace 9 silent] beeper"
#           ];
#           windowrulev2 = [
#             "group set,title:Beeper,class:Beeper"
#           ];
#         };
#       };
#     })
#   ]);
# }
