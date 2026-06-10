{ config, ... }: {
    
    imports = [
        ../../hardware.nix
        ./packages.nix
        ./services.nix
    ];

config = {

    #--- Host Options ---------------------------
    host.system = {
        hostname = "nix-home";
    };


    #--- Modules --------------------------------
    core = {
        bootloader.useGrub = true;
        audio.monoPlayback.enable = true;
        graphics.nvidia.enable = true;
    };

    modules.system = {
        steam.enable = true;
        hardware.wifi.enable = true;
        boot = {
            tuigreet.enable = true;
            swap.enable = true;
            zram.enable = true;
        };
    };


    #--- Options --------------------------------

};}
