{ config, lib, ... }: let
    option = config.modules.system.hardware.graphics;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.system.hardware.graphics = {
    enable = lib.mkEnableOption "Graphics";

    nvidia = lib.mkEnableOption "Nvidia Drivers";
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable (lib.mkMerge [
    {
        boot.initrd.availableKernelModules = [ "amdgpu" "i915" ];

        hardware.graphics = {
            enable = true;
            enable32Bit = true;
        };
    }

    (lib.mkIf option.nvidia {
        services.xserver.videoDrivers = [ "nvidia"  ];

        hardware.nvidia = {
            modesetting.enable = true;
            open = true;
            nvidiaSettings = true;
        };
    })
]);}
