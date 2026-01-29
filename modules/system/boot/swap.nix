{ config, lib, ... }: {
options.modules.system.boot.swap.enable = lib.mkEnableOption "Swapfile";

config = lib.mkIf config.modules.system.boot.swap.enable {

    swapDevices = [{
        device = "/swapfile";
        size = 8192;
        priority = 0;
    }];

};}
