{ pkgs, ... }: 
let
  dependencies = with pkgs; [
    (pkgs.nerdfonts.override {
      fonts = [
        "IBMPlexMono"
				"Iosevka"
				"IosevkaTerm"
      ];
    })
  ];
in {
  home.packages = dependencies;

  fonts.fontconfig.enable = true;
}
