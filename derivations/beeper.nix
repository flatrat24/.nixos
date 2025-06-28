{ pkgs, ... }: let
  pname = "beepertexts";
  version = "1.0.0";

  src = pkgs.fetchurl {
    url = "https://api.beeper.com/desktop/download/linux/x64/stable/com.automattic.beeper.desktop";
    # hash = "sha256-rzFT7NfXeFt9W3DjJ0yyCzTtPSdB+FjYQHjxPbeMciU=";
    hash = "sha256-eRA/9OAWcYsn1C8xuC6NFj2/HxOHT0YISDC9Kp8H/Yg=";
  };
  appimageContents = pkgs.appimageTools.extract {inherit pname version src;};
in
  pkgs.appimageTools.wrapType2 {
    inherit pname version src;
    pkgs = pkgs;
    extraInstallCommands = ''
        install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
        substituteInPlace $out/share/applications/${pname}.desktop \
          --replace 'Exec=AppRun' 'Exec=${pname}'
        cp -r ${appimageContents}/usr/share/icons $out/share

        # unless linked, the binary is placed in $out/bin/cursor-someVersion
        # ln -s $out/bin/${pname}-${version} $out/bin/${pname}
    '';

    extraBwrapArgs = [
      "--bind-try /etc/nixos/ /etc/nixos/"
    ];

    # vscode likes to kill the parent so that the
    # gui application isn't attached to the terminal session
    dieWithParent = false;

    extraPkgs = pkgs: with pkgs; [
      unzip
      autoPatchelfHook
      asar
      # override doesn't preserve splicing https://github.com/NixOS/nixpkgs/issues/132651
      (buildPackages.wrapGAppsHook.override {inherit (buildPackages) makeWrapper;})
    ];
  }
