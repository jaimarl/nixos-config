{ config, lib, pkgs, user, ... }: let enabledModules = {
    modules.system = {
        # Enable Modules
        hardware.bluetooth.enable = true;
        hardware.wifi.enable = true;
        hardware.audioMono.enable = true;
        boot.swap.enable = true;
        boot.zram.enable = true;
        gaming.enable = true;
    };}; in {

    imports = [
        ./.hardware.nix
        ./imports/packages.nix
        ./imports/services.nix
    ];

config = enabledModules // {

    # Hostname
    networking.hostName = "nix-btw";

#--------------------------------------------------------------------
    users.users.${user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "power" ];
    };
};}
