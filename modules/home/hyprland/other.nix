{ config, lib, ... }: {
config = lib.mkIf config.modules.home.hyprland.enable {

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
