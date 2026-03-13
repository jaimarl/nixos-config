{ config, lib, ... }: {

#--- [ Config ] -----------------------------------------------------
config = {

    boot.loader = {
        systemd-boot = {
            enable = true;
            configurationLimit = 10;
        };
        efi.canTouchEfiVariables = true;
    };

};}
