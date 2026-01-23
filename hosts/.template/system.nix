{ config, pkgs, user, ... }: let module = ../../modules/system; in {
    imports = [
        ./.hardware.nix
        ../../common/system.nix
        ./packages.nix
        ./services.nix
    ] ++ (map (name: module + "/${name}.nix") [

    ]);

    disabledModules = [] ++ (map (name: module + "/${name}.nix") [

    ]);

    networking.hostName = "nixos";

    users.users.${user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "power" ];
    };

    # Default Options Override
}
