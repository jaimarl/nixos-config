{ config, pkgs, user, ... }: let module = ../../modules/system; in {
    imports = [
        ./.hardware.nix
        ../../common/system.nix
        ./packages.nix
        ./services.nix
    ] ++ (map (name: module + "/${name}.nix") [
        # Modules
        "tuigreet"
        "bluetooth"
        "wifi"
        "sound-mono-playback"
        "zram"
        "swap"
    ]);

    disabledModules = [] ++ (map (name: module + "/${name}.nix") [

    ]);

    networking.hostName = "nix-btw";

    users.users.${user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "power" ];
    };

    # Default Options Override
}
