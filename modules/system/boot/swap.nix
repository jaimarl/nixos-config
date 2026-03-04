{ config, lib, ... }: {
options.modules.system.boot.swap.enable = lib.mkEnableOption "Swapfile";

options.modules.system.boot.swap = {
    size = lib.mkOption { type = lib.types.int; default = 4096; };
};

config = lib.mkIf config.modules.system.boot.swap.enable {

    swapDevices = [{
        device = "/swapfile";
        size = config.modules.system.boot.swap.size;
        priority = 0;
    }];

};}
