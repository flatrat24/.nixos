{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.zenBrowser;
  dependencies = with pkgs; [
    inputs.zen-browser.packages."${system}".default
  ];
in {
  options = {
    zenBrowser.enable = lib.mkEnableOption "enable zenBrowser";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
  ]);
}
