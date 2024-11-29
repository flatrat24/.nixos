{ pkgs, ... }: 

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (pkgs.nerdfonts.override {
      fonts = [
        "IBMPlexMono"
	"Iosevka"
	"IosevkaTerm"
      ];
    })
  ];
}
