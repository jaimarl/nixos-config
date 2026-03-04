{ config, lib, ... }: {
options.modules.system.boot.bootloader.enable = lib.mkEnableOption "Systemd Bootloader";

config = lib.mkIf config.modules.system.boot.bootloader.enable {

    boot.loader = {
        systemd-boot = {
            enable = true;
            configurationLimit = 10;
        };
        efi.canTouchEfiVariables = true;
    };

};}
