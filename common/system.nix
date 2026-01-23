{ config, pkgs, stateVersion,... }: let module = ../modules/system; in {
    imports = [
        ./packages.nix
        ./services.nix
    ] ++ (map (name: module + "/${name}.nix") [
        # Modules
        "bootloader"
        "graphics"
        "sound"
        "aliases"
        "zsh"
    ]);

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
