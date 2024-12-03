{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Minecraft
    prismlauncher

    # Mindustry
    mindustry-wayland
  ];
}
