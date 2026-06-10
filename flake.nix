{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
        
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        noctalia = {
            url = "github:noctalia-dev/noctalia";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        spicetify-nix = {
            url = "github:Gerg-L/spicetify-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        
        nixcord.url = "github:FlameFlag/nixcord";
        stylix.url = "github:nix-community/stylix";
        apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
        zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
    };

    outputs = { nixpkgs, nixpkgs-stable, home-manager, ... } @ inputs: let
        lib = nixpkgs.lib;

        getDirs = dir:
            if builtins.pathExists dir
            then builtins.attrNames (lib.filterAttrs (n: v: v == "directory" && !lib.hasPrefix "." n) (builtins.readDir dir))
            else [ ];

        mkHost = host: let
            hostCfg = import ./hosts/${host};
            system = hostCfg.system or "x86_64-linux";
            stateVersion = hostCfg.stateVersion;
            
            pkgsCfg = ./hosts/${host}/config/nixpkgs.nix;
            stable = import nixpkgs-stable { inherit system; config = (import pkgsCfg).nixpkgs.config; };
            stableOverlay = final: prev: { inherit stable; };
            
            users = getDirs ./hosts/${host}/users;
            specialArgs = { inherit inputs stable host stateVersion users; };
        in lib.nixosSystem {
            inherit system specialArgs;
            modules = [
                pkgsCfg
                ./core/system
                ./hosts/${host}/config/system
                
                {
                    system.stateVersion = stateVersion;
                    nix.settings.experimental-features = [ "nix-command" "flakes" ];
                    nixpkgs.overlays = [ stableOverlay ];
                }
                
                home-manager.nixosModules.home-manager {
                    home-manager.extraSpecialArgs = specialArgs;
                    home-manager.users = lib.genAttrs users (user: {
                        imports = [
                            pkgsCfg
                            ./core/home
                            ./hosts/${host}/config/home
                            ./hosts/${host}/users/${user}
                        ];
                        
                        nixpkgs.overlays = [ stableOverlay ];
                        home = { inherit stateVersion; username = user; homeDirectory = "/home/${user}"; };
                    });
                }
            ] ++ map (user: { pkgs, ... }: {
                users.users.${user} = { isNormalUser = true; } // (import ./hosts/${host}/users/${user}/user.nix { inherit pkgs; });
            }) users;
        };

    in {
        nixosConfigurations = lib.genAttrs (getDirs ./hosts) mkHost;
    };
}
