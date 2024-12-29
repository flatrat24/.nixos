{
  description = "NixOS System Flake";

  inputs = {
    ##--- follow nixpkgs ---##
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";  # this selects the release-branch and needs to match Nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ##--- follow hyprland ---##
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    ##--- others ---##
    textfox.url = "github:adriankarlen/textfox";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    ags.url = "github:Aylur/ags";
    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
    wallpapers = {
      url = "github:ethananthony271/wallpapers";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      leo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/loque/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.ea = import ./hosts/loque/home.nix;
              backupFileExtension = "hm-backup";
              extraSpecialArgs = { inherit inputs; };
            };
          }
          inputs.stylix.nixosModules.stylix
          inputs.minegrub-theme.nixosModules.default
        ];
      };
      leoito = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/frame/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.ea = import ./hosts/frame/home.nix;
              backupFileExtension = "hm-backup";
              extraSpecialArgs = { inherit inputs; };
            };
          }
          inputs.nixos-hardware.nixosModules.framework-13-7040-amd
          inputs.stylix.nixosModules.stylix
          inputs.minegrub-theme.nixosModules.default
        ];
      };
    };
  };
}
