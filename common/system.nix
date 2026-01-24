{ config, pkgs, stateVersion,... }: let module = ../modules/system; in {
    imports = [
        ./imports/packages.nix
        ./imports/services.nix
    ] ++ (map (name: module + "/${name}.nix") [
        "bootloader"
        "graphics"
        "sound"
        "aliases"
        "zsh"

        "hyprland"
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
