{ config, lib, ... }: {
options.modules.system.hardware.graphics.enable = lib.mkEnableOption "Graphics";

config = lib.mkIf config.modules.system.hardware.graphics.enable {

    boot.initrd.availableKernelModules = [ "amdgpu" "i915" ];

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };

};}
