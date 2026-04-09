{ config, osConfig, lib, ... }: let
    option = config.modules.home.desktop.hyprland;
in {

#--- [ Config ] -----------------------------------------------------
config = {

    wayland.windowManager.hyprland.settings = {
        general = {
            gaps_in = 3;
            gaps_out = 6;

            border_size = 2;
        };

        decoration = {
            rounding = 5;
            rounding_power = 3;

            blur = {
                special = true;
                size = 10;
                passes = 3;
            };
        };
    };

};}
