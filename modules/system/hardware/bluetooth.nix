{ config, lib, pkgs, ... }: {
options.modules.system.hardware.bluetooth.enable = lib.mkEnableOption "Bluetooth";

config = lib.mkIf config.modules.system.hardware.bluetooth.enable {

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
