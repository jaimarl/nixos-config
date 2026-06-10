{ config, ... }: {
    
    imports = [
        ../../hardware.nix
        ./packages.nix
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
