{
  description = "NixOS System Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      leo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./config/system/basic-packages.nix
          ./config/system/network.nix
          # ./config/system/nvidia.nix
          ./config/system/nvidia-hyprland.nix
          ./config/system/bluetooth.nix
          ./config/system/grub.nix
          # ./config/system/sddm.nix
          ./hosts/loque/configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ea = import ./home.nix;
          }
        ];
      };
      leoito = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./config/system/basic-packages.nix
          ./config/system/stylix.nix
          ./config/system/network.nix
          # ./config/system/nvidia.nix
          # ./config/system/nvidia-hyprland.nix
          ./config/system/bluetooth.nix
          ./config/system/grub.nix
          # ./config/system/sddm.nix
          ./hosts/frame/configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ea = import ./home.nix;
	        }

          inputs.stylix.nixosModules.stylix
        ];
      };
    };
  };
}
