{ config, pkgs, user, ... }: {
    imports = [
        ./.hardware.nix
        ../../common/system.nix
        ./packages.nix
        ./services.nix

        # Modules
        # ../../modules/system/tuigreet.nix
    ];

    networking.hostName = "nixos";

    users.users.${user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "power" ];
    };

    # Default Options Override
}
