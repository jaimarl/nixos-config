{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        catppuccin.url = "github:catppuccin/nix";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, catppuccin, home-manager, ... } @ inputs:
        let
            addHost = { host, stateVersion, user, system ? "x86_64-linux" }: nixpkgs.lib.nixosSystem {
                system = system;
                specialArgs = { inherit inputs host stateVersion user; };
                modules = [
                    ./hosts/${host}/system.nix
                    home-manager.nixosModules.home-manager {
                    home-manager.extraSpecialArgs = { inherit host stateVersion user; };
                    home-manager.users.${user} = { imports = [
                        ./common/home.nix
                        ./hosts/${host}/home.nix
                        catppuccin.homeModules.catppuccin
                    ];};}
                ];
            }; 
        in {

        nixosConfigurations = {
            t14-gen2 = addHost { host = "t14-gen2"; stateVersion = "25.11"; user = "jaimarl"; };
        };
    };
}
