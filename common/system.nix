{ config, pkgs, stateVersion,... }: {
    imports = [
        ../modules/system/bootloader.nix
        ../modules/system/graphics.nix
        ../modules/system/sound.nix
        ../modules/system/shell.nix

        ./packages.nix
        ./services.nix
    ];

    time.timeZone = "Europe/Moscow";
    i18n.defaultLocale = "ru_RU.UTF-8";

    console = {
        font = "ter-p24b";
        earlySetup = true;
        packages = [ pkgs.terminus_font ];
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    system.stateVersion = stateVersion;
}
