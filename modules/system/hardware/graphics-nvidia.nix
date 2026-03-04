{ config, lib, ... }: {
options.modules.system.hardware.graphicsNvidia.enable = lib.mkEnableOption "Nvidia Drivers";

config = lib.mkIf config.modules.system.hardware.graphicsNvidia.enable {

    services.xserver.videoDrivers = [ "nvidia"  ];

    hardware.nvidia = {
        modesetting.enable = true;
        open = true;
        nvidiaSettings = true;
    };

};}
