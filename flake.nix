{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprland.url = "github:hyprwm/Hyprland/v0.54.3";
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

        zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
    };

    outputs = { nixpkgs, nixpkgs-stable, home-manager, nixcord, stylix, spicetify-nix, apple-fonts, zapret-discord-youtube, ... } @ inputs:
        let
            hostsDir = ./hosts;
            hostDirs = builtins.attrNames (
                nixpkgs.lib.filterAttrs (n: v: v == "directory" && n != ".template") (builtins.readDir hostsDir)
            );

            hosts = nixpkgs.lib.genAttrs hostDirs (host: {
                stateVersion = import ./hosts/${host}/state-version.nix;
            });

            mkHost = { host, stateVersion, system ? "x86_64-linux" }: let
                pkgsCfg = ./hosts/${host}/config/packages-config.nix;
                stable = import nixpkgs-stable { inherit system; config = (import pkgsCfg).nixpkgs.config; };

                usersDir = ./hosts/${host}/users;
                users = if builtins.pathExists usersDir 
                        then builtins.attrNames (nixpkgs.lib.filterAttrs (n: v: v == "directory") (builtins.readDir usersDir)) 
                        else [];

                hmUsers = nixpkgs.lib.genAttrs users (user: {
                    imports = [
                        pkgsCfg 
                        ./common/home.nix
                        ./hosts/${host}/config/home.nix
                        nixcord.homeModules.nixcord
                        stylix.homeModules.stylix
                        spicetify-nix.homeManagerModules.default 
                        ./hosts/${host}/users/${user}/home.nix
                        ./hosts/${host}/users/${user}/packages.nix
                    ];
                    home.username = user;
                    home.homeDirectory = "/home/${user}";
                    home.stateVersion = stateVersion;
                });

                userSystemModules = map (user: { pkgs, ... }: {
                    users.users.${user} = {
                        isNormalUser = true;
                    } // (import ./hosts/${host}/users/${user} { inherit pkgs; });
                }) users;

            in nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs stable host stateVersion users; }; 
                modules = [
                    pkgsCfg 
                    ./common/system.nix
                    ./hosts/${host}/config/system.nix
                    zapret-discord-youtube.nixosModules.default
                    
                    home-manager.nixosModules.home-manager {
                        home-manager.extraSpecialArgs = { inherit inputs stable host stateVersion users; };
                        home-manager.users = hmUsers;
                    }
                ] ++ userSystemModules;
            };
        in {
        nixosConfigurations = nixpkgs.lib.mapAttrs (hostname: params:
            mkHost {
                host = hostname;
                inherit (params) stateVersion;
            }
        ) hosts;
    };
}
