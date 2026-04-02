{ config, lib, ... }: let
    option = config.core.graphics;
in {

#--- [ Options ] ----------------------------------------------------
options.core.graphics = {
    nvidia.enable = lib.mkOption { type = lib.types.bool; default = false; };
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
