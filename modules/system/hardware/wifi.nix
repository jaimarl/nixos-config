{ config, lib, pkgs, ... }: let
    option = config.modules.system.hardware.wifi;
in {

#--- [ Options ] ---------------------------------------------------- 
options.modules.system.hardware.wifi = {
    enable = lib.mkEnableOption "WiFi";
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    environment.systemPackages = with pkgs; [
        impala
    ];

    networking.wireless.iwd.enable = true;

};}
