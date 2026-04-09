{ config, hmConfig, lib, pkgs, ... }: let
    hostOption = config.host.system;
in {
    
    imports = [
        ../hardware.nix
        ./packages-system.nix
        ./services.nix
    ];

config = {

    #--- Host Options ---------------------------
    host.system = {
        hostname = "nix-btw";
        hasBattery = true;
    };


    #--- Modules --------------------------------
    core = {
        bootloader.useGrub = true;
        audio.monoPlayback.enable = true;
    };

    modules.system = {
        steam.enable = true;
        virtualisation.enable = true;
        zapret = {
            enable = true;
            strategy = "general(ALT)";
        };
        hardware = {
            wifi.enable = true;
            bluetooth.enable = true;
        };
        boot = {
            tuigreet.enable = true;
            swap.enable = true;
            zram.enable = true;
        };
    };


    #--- Options --------------------------------

};}
