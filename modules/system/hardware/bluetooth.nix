{ config, lib, pkgs, ... }: let
    option = config.modules.system.hardware.bluetooth;
in {

#--- [ Options ] ---------------------------------------------------- 
options.modules.system.hardware.bluetooth = {
    enable = lib.mkOption { type = lib.types.bool; default = false; };
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    environment.systemPackages = with pkgs; [
        bluetui
    ];

    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
            General = {
                Enable = "Source,Sink,Media,Socket";
                Experimental = true;
            };
        };
    };

};}
