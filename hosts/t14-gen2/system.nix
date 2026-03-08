{ config, hmConfig, lib, pkgs, user, ... }: {
    
    imports = [
        ./hardware.nix
        ./imports/packages-system.nix
        ./imports/services.nix
    ];

config = {

    # Enable & Configure Modules
    modules.system = {
        hardware = {
            wifi.enable = true;
            bluetooth.enable = true;
        };
        shell.zsh.enable = true;
        boot = {
            tuigreet.enable = true;
            swap.enable = true;
            zram.enable = true;
        };
        wm.hyprland = {
            enable = true;
            opacity.enable = false;
            monitors = [ "eDP-1, 1920x1080@60, 0x0, 1" ];
        };
    };

    # Hostname
    networking.hostName = "nix-btw";

#--------------------------------------------------------------------
    users.users.${user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "power" ];
    };
};}
