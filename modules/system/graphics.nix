{
    boot.initrd.availableKernelModules = [ "amdgpu" "i915" ];

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };
}
