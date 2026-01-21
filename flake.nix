{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, home-manager, ... } @ inputs:
        let
            addHost = { host, stateVersion, system ? "x86_64-linux" }: nixpkgs.lib.nixosSystem {
                system = system;
                specialArgs = { inherit inputs stateVersion; };
                modules = [
                    ./hosts/${host}/system.nix
                    home-manager.nixosModules.home-manager {
                    home-manager.extraSpecialArgs = { inherit stateVersion; };
                    home-manager.users.jaimarl = { imports = [
                        ./common/home.nix
                        ./hosts/${host}/home.nix
                    ];};}
                ];
            }; 
        in {

        nixosConfigurations = {
            t14-gen2 = addHost { host = "t14-gen2"; stateVersion = "25.11"; };
        };
    };
}
