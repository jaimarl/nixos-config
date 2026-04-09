{ config, osConfig, lib, ... }: let
    option = config.modules.home.desktop.hyprland;
in {

#--- [ Config ] -----------------------------------------------------
config = { 

    wayland.windowManager.hyprland.settings = {
        input = {
            kb_layout = "us, ru";
            kb_options = "grp:alt_shift_toggle";
        };

        cursor = {
            zoom_disable_aa = true;
        };
    };

};}
