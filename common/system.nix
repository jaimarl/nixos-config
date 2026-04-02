{ config, hmConfig, lib, pkgs, stateVersion, ... }: let
    hostOption = config.host.system;
in {

    imports = [
        ./imports/packages-system.nix
        ./imports/services.nix
        ../core/system
        ../modules/system
    ];

#--- [ Host Options ] -----------------------------------------------
options.host.system = {
    hostname = lib.mkOption { type = lib.types.str; default = "nixos"; };
    locale = lib.mkOption { type = lib.types.str; default = "ru_RU.UTF-8"; };
    timeZone = lib.mkOption { type = lib.types.str; default = "Europe/Moscow"; };

    hasBattery = lib.mkOption { type = lib.types.bool; default = false; };
};


#--- [ Config ] -----------------------------------------------------
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
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = stateVersion;
};}
