{ pkgs, ... }: 

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    kitty
    (pkgs.nerdfonts.override {
      fonts = [
        "IBMPlexMono"
				"Iosevka"
				"IosevkaTerm"
      ];
    })
  ];
}
