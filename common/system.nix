{ config, hmConfig, lib, pkgs, stateVersion, user, ... }: let
    hostOption = config.host.system;
in {

    imports = [
        ./imports/host-options.nix
        ./imports/packages-system.nix
        ./imports/services.nix
        ../modules/core/system
        ../modules/system
    ];

config = {

    console = {
        font = "ter-p24b";
        earlySetup = true;
        packages = [ pkgs.terminus_font ];
    };

    networking.hostName = hostOption.hostname;
    time.timeZone = hostOption.timeZone;
    i18n.defaultLocale = hostOption.locale;

#--------------------------------------------------------------------
    _module.args.hmConfig = config.home-manager.users.${user};
    
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = stateVersion;
};}
