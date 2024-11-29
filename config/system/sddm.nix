{ pkgs, ... }: {
  services.displayManager.sddm = {
    enable = true;
    # defaultSession = "hyprland";
    wayland.enable = true;
  };
}
