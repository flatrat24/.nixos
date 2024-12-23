{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    # (texlive.withPackages (ps: with ps; [
    #   darkmode
    #   circuitikz
    #   latexmk
    # ]))
    # biber
    texliveFull
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
