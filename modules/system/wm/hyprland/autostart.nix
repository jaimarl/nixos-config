{ config, osConfig, lib, pkgs, ... }: let
    option = osConfig.modules.system.wm.hyprland;
in {

#--- [ Config ] -----------------------------------------------------
config = {

    wayland.windowManager.hyprland.settings.exec-once = [
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "swww-daemon"
        "hyprland-per-window-layout"
    ];

};}
