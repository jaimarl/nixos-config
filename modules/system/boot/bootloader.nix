{ config, lib, ... }: let
    option = config.modules.system.boot.bootloader;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.system.boot.bootloader = {
    enable = lib.mkEnableOption "Systemd Bootloader";
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    boot.loader = {
        systemd-boot = {
            enable = true;
            configurationLimit = 10;
        };
        efi.canTouchEfiVariables = true;
    };

};}
