{ inputs, pkgs, ... }: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "/home/ea/.nixos/config/home/sources/hypr/assets/grove.png"
      ];
      wallpaper = [
        ",/home/ea/.nixos/config/home/sources/hypr/assets/grove.png"
      ];
    };
  };
}
