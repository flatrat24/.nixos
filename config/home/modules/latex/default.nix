{ pkgs, lib, config, ... }:
let
  cfg = config.latex;
  tex = (pkgs.texlive.combine { inherit (pkgs.texlive) scheme-full physics; });
  dependencies = [
    tex
  ];
in {
  imports = [ ];

  options = {
    latex = {
      enable = lib.mkEnableOption "enables latex";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
  ]);
}
