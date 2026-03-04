{ config, lib, pkgs, ... }: {
options.modules.system.hardware.wifi.enable = lib.mkEnableOption "WiFi";

config = lib.mkIf config.modules.system.hardware.wifi.enable {

    environment.systemPackages = with pkgs; [
        impala
    ];

    networking.wireless.iwd.enable = true;

};}
