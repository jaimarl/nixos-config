{ config, lib, pkgs, ... }: let
    option = config.core.bootloader;
in {

#--- [ Options ] ----------------------------------------------------
options.core.bootloader = {
    useGrub = lib.mkOption { type = lib.types.bool; default = false; };
};


#--- [ Config ] -----------------------------------------------------
config = {

    boot.loader = {
        systemd-boot = {
            enable = !option.useGrub;
            configurationLimit = 10;
        };

        grub = {
            enable = option.useGrub;
            device = "nodev";
            efiSupport = true;
            useOSProber = true;
            splashImage = null;
        };

        efi.canTouchEfiVariables = true;
    };

};}
