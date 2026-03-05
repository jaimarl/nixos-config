{ config, hmConfig, lib, pkgs, user, ... }: let enabledModules = {
    modules.system = {
        # Enable Modules
        hardware.bluetooth.enable = true;
        hardware.wifi.enable = true;
        hardware.audio.monoPlayback = true;
        boot.swap.enable = true;
        boot.zram.enable = true;
        wm.hyprland.enable = true;
        gaming.enable = true;
    };}; in {

    imports = [
        ./.hardware.nix
        ./imports/packages-system.nix
        ./imports/services.nix
    ];

config = lib.recursiveUpdate enabledModules {

    # Hostname
    networking.hostName = "nix-btw";

    modules.system.wm.hyprland.monitors = [ "eDP-1, 1920x1080@60, 0x0, 1" ];

#--------------------------------------------------------------------
    users.users.${user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "power" ];
    };
};}
