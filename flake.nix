{
  description = "NixOS System Flake";

  inputs = {
    ##--- follow nixpkgs ---##
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
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
    # Hyprspace = {
    #   url = "github:KZDKM/Hyprspace";
    #   inputs.hyprland.follows = "hyprland";
    # };

    ##--- Fabric ---##
    fabric = {
      url = "github:Fabric-Development/fabric";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fabric-cli = {
      url = "github:HeyImKyu/fabric-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ##--- others ---##
    textfox.url = "github:adriankarlen/textfox";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    ignis.url = "github:linkfrg/ignis";
    wallpapers = {
      url = "github:flatrat24/wallpapers";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    fabric,
    fabric-cli,
    ...
    } @ inputs:
    let
      systemArchitecture = "x86_64-linux";
      overlays = [
        (final: prev: {fabric-run-widget = fabric.packages.${systemArchitecture}.run-widget;})
        (final: prev: {fabric = fabric.packages.${systemArchitecture}.default;})
        (final: prev: {fabric-cli = fabric-cli.packages.${systemArchitecture}.default;})
        fabric.overlays.${systemArchitecture}.default
      ];
    in
    {
    nixosConfigurations = {
      leo = nixpkgs.lib.nixosSystem {
        system = systemArchitecture;
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
        ];
      };
      leoito = nixpkgs.lib.nixosSystem {
        system = systemArchitecture;
        specialArgs = {
          inherit inputs;
          pkgs = import nixpkgs {
            system = systemArchitecture;
            overlays = overlays;
            config.allowUnfree = true;
          };
        };
        modules = [
          ./hosts/frame/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              extraSpecialArgs = {
                pkgs = import nixpkgs {
                  system = systemArchitecture;
                  config.allowUnfree = true;
                };
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              users.ea = import ./hosts/frame/home.nix;
              backupFileExtension = "hm-backup";
              extraSpecialArgs = { inherit inputs; };
            };
            nixpkgs.overlays = [
              overlays
            ];
          }
          inputs.nixos-hardware.nixosModules.framework-13-7040-amd
          inputs.stylix.nixosModules.stylix
        ];
      };
    };
  };
}
