{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    keepassxc
    keepassxc-go
    keepass-diff
  ];
in {
  options = {
    passwords = {
      keepass.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = lib.mkIf config.passwords.keepass.enable {
    home.packages = dependencies;
  };
}
