{ config, pkgs, ... }: {
    imports = [
        ./.hardware.nix
        ../../common/system.nix
        ./packages.nix
        ./services.nix

        # Modules
        ../../modules/system/tuigreet.nix
        ../../modules/system/bluetooth.nix
        ../../modules/system/wifi.nix
        ../../modules/system/sound-mono-playback.nix
        ../../modules/system/zram.nix
        ../../modules/system/swap.nix
    ];

    networking.hostName = "nix-btw";

    # Default Options Override
    programs.firefox.enable = true;

    # Home Manager
}
