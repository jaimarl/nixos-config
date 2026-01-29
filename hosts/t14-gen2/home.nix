{ config, lib, pkgs, stateVersion, user, ... }: let enabledModules = {
    modules.home = {
        # Enable Modules
        hyprland.enable = true;
    };}; in {

    imports = [
        ./imports/programs.nix
    ];
    
config = enabledModules // {

    # Hyprland
    wayland.windowManager.hyprland = {
        settings = {
            monitor = [
                "eDP-1, 1920x1080, 0x0, 1"
            ];
        };
    };

#--------------------------------------------------------------------
    home = {
        username = user;
        homeDirectory = "/home/${user}";
        stateVersion = stateVersion;
    };
};}
