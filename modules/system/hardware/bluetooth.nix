{ config, lib, pkgs, ... }: let
    option = config.modules.system.hardware.bluetooth;
in {

#--- [ Options ] ---------------------------------------------------- 
options.modules.system.hardware.bluetooth = {
    enable = lib.mkEnableOption "Bluetooth";
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
