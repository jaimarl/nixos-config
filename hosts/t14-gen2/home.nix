{ config, osConfig, lib, pkgs, stateVersion, user, ... }: let enabledModules = {
    modules.home = {
        # Enable Modules
    };}; in {

    imports = [
        ./imports/packages-home.nix
    ];
    
config = lib.recursiveUpdate enabledModules {
    
    # Options
    wayland.windowManager.hyprland.settings = {
        bind = [
            ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ];
        binde = [
            ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
            ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 2%+"

            ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
            ", XF86MonBrightnessUp, exec, brightnessctl s 5%+"
        ];
    };

#--------------------------------------------------------------------
    home = {
        username = user;
        homeDirectory = "/home/${user}";
        stateVersion = stateVersion;
    };
};}
