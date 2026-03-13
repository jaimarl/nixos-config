{ config, lib, ... }: let
    option = config.modules.system.boot.swap;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.system.boot.swap = {
    enable = lib.mkOption { type = lib.types.bool; default = false; };

    size = lib.mkOption { type = lib.types.int; default = 4096; };
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    swapDevices = [{
        device = "/swapfile";
        size = config.modules.system.boot.swap.size;
        priority = 0;
    }];

};}
