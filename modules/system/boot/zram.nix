{ config, lib, ... }: let
    option = config.modules.system.boot.zram;
in {

#--- [ Options ] ---------------------------------------------------- 
options.modules.system.boot.zram = {
    enable = lib.mkEnableOption "zRam";
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    zramSwap = {
        enable = true;
        algorithm = "lz4";
        memoryPercent = 100;
        priority = 999;
    };

};}
