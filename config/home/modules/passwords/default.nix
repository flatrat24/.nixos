{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [ ];
in {
  imports = [
    ./pass/default.nix
    ./keepass/default.nix
  ];

  options = {
    passwords = {
      enable = lib.mkEnableOption "enables passwords";
    };
  };

  config = lib.mkIf config.passwords.enable {
    home.packages = with pkgs; [
      keepassxc
      keepassxc-go
      keepass-diff
    ];
  };
}
