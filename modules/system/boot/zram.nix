{ config, lib, ... }: {
options.modules.system.boot.zram.enable = lib.mkEnableOption "zRam";

config = lib.mkIf config.modules.system.boot.zram.enable {

    zramSwap = {
        enable = true;
        algorithm = "lz4";
        memoryPercent = 100;
        priority = 999;
    };

};}
