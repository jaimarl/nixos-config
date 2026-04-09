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
        hostname = "nix-home";
    };


    #--- Modules --------------------------------
    core = {
        audio.monoPlayback.enable = true;
        bootloader.useGrub = true;
        graphics.nvidia.enable = true;
    };

    modules.system = {
        steam.enable = true;
        zapret = {
            enable = true;
            strategy = "general(ALT)";
        };
        hardware.wifi.enable = true;
        boot = {
            tuigreet.enable = true;
            swap.enable = true;
            zram.enable = true;
        };
    };


    #--- Options --------------------------------

};}
