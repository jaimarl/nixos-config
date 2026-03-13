{ config, osConfig, lib, pkgs, ... }: let
    option = osConfig.modules.system.desktop.hyprland;
in {

#--- [ Config ] -----------------------------------------------------
config = {

    wayland.windowManager.hyprland.settings = {
        exec-once = [
            "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
            "${pkgs.hyprland-per-window-layout}/bin/hyprland-per-window-layout"
            "${pkgs.wl-clip-persist}/bin/wl-clip-persist -c regular"
            "${pkgs.swww}/bin/swww-daemon"
        ];
    };

};}
