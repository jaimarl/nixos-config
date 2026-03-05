{ config, osConfig, lib, ... }: let
    option = osConfig.modules.system.wm.hyprland;
in {

#--- [ Config ] -----------------------------------------------------
config = {

    wayland.windowManager.hyprland.settings.exec-once = [
        "waybar"
    ];

    # programs.waybar.enable = true;

};}
