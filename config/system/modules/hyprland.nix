{ inputs, pkgs, lib, config, ... }: {
  options = {
    hyprland.enable = lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    # xdg.portal = {
    #   enable = lib.mkDefault true;
    #   extraPortals = with pkgs; [
    #     xdg-desktop-portal-hyprland
    #   ];
    #   xdgOpenUsePortal = lib.mkDefault true;
    # };

    environment.systemPackages = with pkgs; (if (config.nvidia.enable == true) then [egl-wayland] else []);
  };
}
