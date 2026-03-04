{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        self.submodules = true;

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        stylix = {
            url = "github:nix-community/stylix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    };

    outputs = { nixpkgs, home-manager, stylix, apple-fonts, ... } @ inputs:
        let
            hosts = {
                "t14-gen2" = { stateVersion = "25.11"; user = "jaimarl"; };
            };

            mkHost = { host, stateVersion, user, system ? "x86_64-linux" }: nixpkgs.lib.nixosSystem {
                system = system;
                specialArgs = { inherit inputs host stateVersion user; };
                modules = [
                    ./common/system.nix
                    ./common/global-options.nix
                    ./hosts/${host}/system.nix
                    home-manager.nixosModules.home-manager {
                    home-manager.extraSpecialArgs = { inherit inputs host stateVersion user; };
                    home-manager.users.${user} = { imports = [
                        ./common/home.nix
                        ./hosts/${host}/home.nix
                        stylix.homeModules.stylix
                    ];};}
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
