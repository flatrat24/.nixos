{ lib
, qtbase
, qtsvg
, qtgraphicaleffects
, qtquickcontrols2
, wrapQtAppsHook
, stdenvNoCC
, fetchFromGitHub
}:
stdenvNoCC.mkDerivation
rec {
  pname = "sddm-astronaut-theme";
  version = "1..0";
  dontBuild = true;
  src = fetchFromGitHub {
    owner = "Keyitdev";
    repo = "sddm-astronaut-theme";
    rev = "7123e3870baeeb58298abd80a4b4e1216872d1d9";
    hash = "sha256-DOzsmXwFjG8GlD8TkXMCjCQzTU9Fc/S7MUGm5b8OWlY=";
  };

  nativeBuildInputs = [
    wrapQtAppsHook
  ];

  propagatedUserEnvPkgs = [
    qtbase
    qtsvg
    qtgraphicaleffects
    qtquickcontrols2
  ];


  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src $out/share/sddm/themes/sddm-astronaut-theme
  '';

}
