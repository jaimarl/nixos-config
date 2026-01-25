{ config, pkgs, user, ... }: let module = ../../modules/system; in {
    imports = [
        ./.hardware.nix
        ./imports/packages.nix
        ./imports/services.nix
    ] ++ (map (name: module + "/${name}.nix") [
        "tuigreet"
        "bluetooth"
        "wifi"
        "sound-mono-playback"
        "zram"
        "swap"
        "gaming"
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
