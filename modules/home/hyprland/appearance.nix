{ config, lib, ... }: {
config = lib.mkIf config.modules.home.hyprland.enable {

    wayland.windowManager.hyprland.settings = {
        general = {
            gaps_in = 3;
            gaps_out = 6;

            border_size = 2;

            "col.active_border" = "$mauve";
            "col.inactive_border" = "$overlay0";
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
