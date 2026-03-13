{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprland.url = "github:hyprwm/Hyprland/v0.54.1";
        hyprsplit = {
            url = "github:shezdy/hyprsplit";
            inputs.hyprland.follows = "hyprland";
        };

        nixcord.url = "github:FlameFlag/nixcord";

        stylix.url = "github:nix-community/stylix";
        spicetify-nix = {
            url = "github:Gerg-L/spicetify-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    };

    outputs = { nixpkgs, nixpkgs-stable, home-manager, nixcord, stylix, spicetify-nix, apple-fonts, ... } @ inputs:
        let
            hosts = {
                "t14-gen2" = { stateVersion = "25.11"; user = "jaimarl"; };
            };

            mkHost = { host, stateVersion, user, system ? "x86_64-linux" }: let
                pkgsCfg = ./hosts/${host}/imports/packages-config.nix;
                stable = import nixpkgs-stable { inherit system; config = (import pkgsCfg).nixpkgs.config; };
            in nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs stable host stateVersion user; };
                modules = [
                    pkgsCfg 
                    ./common/system.nix
                    ./hosts/${host}/system.nix
                    home-manager.nixosModules.home-manager {
                        home-manager.extraSpecialArgs = { inherit inputs stable host stateVersion user; };
                        home-manager.users.${user} = { imports = [
                            pkgsCfg 
                            ./common/home.nix
                            ./hosts/${host}/home.nix
                            nixcord.homeModules.nixcord
                            stylix.homeModules.stylix
                            spicetify-nix.homeManagerModules.default 
                        ];};
                    }
                ];
            }; 
        in {
        
        nixosConfigurations = nixpkgs.lib.mapAttrs (hostname: params:
            mkHost {
                host = hostname;
                inherit (params) stateVersion user;
            }
        ) hosts;
    };
}
