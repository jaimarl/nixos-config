{ config, lib, ... }: let
    # option = config.modules.system.boot.bootloader;
in {

#--- [ Options ] ----------------------------------------------------
# options.modules.system.boot.bootloader = {
#     # Options
# };


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
