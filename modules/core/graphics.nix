{ config, lib, ... }: let
    option = config.modules.core.graphics;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.core.graphics = {
    nvidia.enable = lib.mkEnableOption "Nvidia Drivers";
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkMerge [

    {
        boot.initrd.availableKernelModules = [ "amdgpu" "i915" ];

        hardware.graphics = {
            enable = true;
            enable32Bit = true;
        };
    }

    (lib.mkIf option.nvidia.enable {
        services.xserver.videoDrivers = [ "nvidia"  ];

        hardware.nvidia = {
            modesetting.enable = true;
            open = true;
            nvidiaSettings = true;
        };
    })

];}
