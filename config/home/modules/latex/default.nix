{ pkgs, lib, config, ... }:
let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-full
      darkmode;
  });
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

  config = lib.mkIf config.latex.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
  ]);
}
