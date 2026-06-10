{ config, lib, pkgs, stateVersion, ... }: let
    hostOption = config.host.system;
    hmUsers = config.home-manager.users;

    isNiriEnabled = lib.any 
        (cfg: lib.attrByPath [ "modules" "home" "desktop" "niri" "enable" ] false cfg) 
        (builtins.attrValues hmUsers);
in {

    imports = [
        ./packages.nix
        ./services.nix

        ./features/aliases.nix
        ./features/audio.nix
        ./features/bootloader.nix
        ./features/graphics.nix
        ./features/polkit.nix

        ../../modules/system
    ];

#--- [ Host Options ] -----------------------------------------------
# DO NOT CHANGE VALUES, USE YOUR HOST CONFIG INSTEAD!
options.host.system = {
    hostname = lib.mkOption { type = lib.types.str; default = "nixos"; };
    locale = lib.mkOption { type = lib.types.str; default = "ru_RU.UTF-8"; };
    timeZone = lib.mkOption { type = lib.types.str; default = "Europe/Moscow"; };

    hasBattery = lib.mkOption { type = lib.types.bool; default = false; };
};


#--- [ Config ] -----------------------------------------------------
config = {

    networking.hostName = hostOption.hostname;
    time.timeZone = hostOption.timeZone;
    i18n.defaultLocale = hostOption.locale;

    console = {
        font = "ter-p24b";
        earlySetup = true;
        packages = [ pkgs.terminus_font ];
    };

    programs.niri = {
        enable = isNiriEnabled;
        useNautilus = false;
    };

};}
