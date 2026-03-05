{ config, osConfig, lib, ... }: let
    option = osConfig.modules.system.wm.hyprland;
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
