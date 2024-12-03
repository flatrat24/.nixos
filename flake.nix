{
  description = "NixOS System Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix/cf8b6e2d4e8aca8ef14b839a906ab5eb98b08561";
    textfox.url = "github:adriankarlen/textfox";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      leo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./config/system/basic-packages.nix
          ./config/system/network.nix
          # ./config/system/nvidia.nix
          ./config/system/nvidia-hyprland.nix # Merge with nvidia.nix
          ./config/system/bluetooth.nix
          ./config/system/grub.nix
          ./config/system/stylix.nix
          ./config/system/syncthing.nix
          ./config/system/pipewire.nix
          # ./config/system/sddm.nix
          ./hosts/loque/configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.ea = import ./home.nix;
              backupFileExtension = "hm-backup";
              extraSpecialArgs = { inherit inputs; };
            };
          }

          inputs.stylix.nixosModules.stylix
        ];
      };
      leoito = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./config/system/basic-packages.nix
          ./config/system/network.nix
          # ./config/system/nvidia.nix
          # ./config/system/nvidia-hyprland.nix
          ./config/system/bluetooth.nix
          ./config/system/grub.nix
          ./config/system/stylix.nix
          ./config/system/syncthing.nix
          ./config/system/pipewire.nix
          # ./config/system/sddm.nix
          ./hosts/frame/configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.ea = import ./home.nix;
              backupFileExtension = "hm-backup";
              extraSpecialArgs = { inherit inputs; };
            };
	        }

          inputs.stylix.nixosModules.stylix
        ];
      };
    };
  };
}
