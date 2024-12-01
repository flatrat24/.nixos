{ pkgs, ... }:
let
  dependencies = with pkgs; [ ];
in {

  # imports = [ ];

  # home.packages = dependencies;

  textfox = {
    enable = true;
    profile = "Ethan";
    config = {};
  };
}
