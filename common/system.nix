{ config, hmConfig, lib, pkgs, stateVersion, user, ... }: {

    imports = [
        # Core Modules
        ../modules/core/bootloader.nix
        ../modules/core/graphics.nix
        ../modules/core/audio.nix
        ../modules/core/aliases.nix
        ../modules/core/polkit-rules.nix

        ./imports/packages-system.nix
        ./imports/services.nix
        ../modules/system
    ];

config = {

    # Localization
    time.timeZone = "Europe/Moscow";
    i18n.defaultLocale = "ru_RU.UTF-8";

    console = {
        font = "ter-p24b";
        earlySetup = true;
        packages = [ pkgs.terminus_font ];
    };

#--------------------------------------------------------------------
    _module.args.hmConfig = config.home-manager.users.${user};
    
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = stateVersion;
};}
