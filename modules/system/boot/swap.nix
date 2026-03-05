{ config, lib, ... }: let
    option = config.modules.system.boot.swap;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.system.boot.swap = {
    enable = lib.mkEnableOption "Swapfile";
};


#--- [ Config ] -----------------------------------------------------
options.modules.system.boot.swap = {
    size = lib.mkOption { type = lib.types.int; default = 4096; };
};

config = lib.mkIf option.enable {

    swapDevices = [{
        device = "/swapfile";
        size = config.modules.system.boot.swap.size;
        priority = 0;
    }];

};}
