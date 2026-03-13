{ config, lib, pkgs, ... }: let
    option = config.modules.system.hardware.wifi;
in {

#--- [ Options ] ---------------------------------------------------- 
options.modules.system.hardware.wifi = {
    enable = lib.mkOption { type = lib.types.bool; default = false; };
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    environment.systemPackages = with pkgs; [
        impala
    ];

    networking.wireless.iwd.enable = true;

};}
