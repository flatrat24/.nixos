{ config, lib, pkgs, ... }:

{
  stylix.base16scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
  stylix.image = ../home/sources/hypr/assets/dock.png;

  environment.systemPackages = with pkgs; [ ];
}
