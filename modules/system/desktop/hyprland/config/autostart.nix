{ config, osConfig, lib, pkgs, ... }: let
    option = osConfig.modules.system.desktop.hyprland;

    awww = pkgs.writeShellScript "start" ''
        if [ -f "$HOME/.cache/wallpaper/current.png" ]; then
            wp set "$HOME/.cache/wallpaper/current.png"
        else
            wp random
        fi;
    '';
in {

#--- [ Config ] -----------------------------------------------------
config = {

    wayland.windowManager.hyprland.settings = {
        exec-once = [
            "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
            "${pkgs.hyprland-per-window-layout}/bin/hyprland-per-window-layout"
            "${pkgs.wl-clip-persist}/bin/wl-clip-persist -c regular"
            "${awww}"
        ];
    };

};}
