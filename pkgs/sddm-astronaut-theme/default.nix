{ pkgs, lib, stdenvNoCC }:
let
  themeConfig = { };
in stdenvNoCC.mkDerivation rec {
  pname = "sddm-astronaut";
  version = "1.0";

  src = pkgs.fetchFromGitHub {
    owner = "ethananthony271";
    repo = "sddm-astronaut-theme";
    rev = "4b6b58505a1cf1f60b0365be3d964b4f68e26ffc";
    hash = "sha256-LJQrcbPvh3VMBrW3mlbF+kwai0+Y6kVD6716IvxjjYk=";
  };

  dontWrapQtApps = true;
  propagatedBuildInputs = with pkgs.kdePackages; [
    qt5compat
    qtsvg
  ];

  installPhase =
    let
      basePath = "$out/share/sddm/themes/sddm-astronaut-theme";
    in
      ''
      mkdir -p ${basePath}
      cp -r $src/* ${basePath}
      ''
    + lib.optionalString (themeConfig != null) ''
      ln -sf ${basePath}/Themes/theme1.conf ${basePath}/theme.conf.user
    '';

  meta = {
    description = "Modern looking qt6 sddm theme";
    homepage = "https://github.com/${src.owner}/${src.repo}";
    license = lib.licenses.gpl3;

    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ danid3v ];
  };
}
