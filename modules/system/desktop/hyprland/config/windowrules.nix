{ config, osConfig, lib, ... }: let
    option = osConfig.modules.system.desktop.hyprland;
in {

#--- [ Config ] -----------------------------------------------------
config = {

    wayland.windowManager.hyprland.settings = {
        "$?" = "match";
        "$mw:" = "monitor_w*";
        "$mh:" = "monitor_h*";
        "$ww:" = "window_w*";
        "$wh:" = "window_h*";
        windowrule = [
            "float 1, keep_aspect_ratio 1, pin 1, move $mw:0.733 $mh:0.72, size $mw:0.25 $mh:0.25, $?:title (Картинка в картинке)"
            "center 1, size $mw:0.6 $mh:0.75, $?:class (firefox), $?:float 1"
            "float 1, fullscreen_state 0, size $mw:0.66 $mh:0.66, $?:class (org.telegram.desktop), $?:title (Просмотр медиа)"

            "float 1, size $mw:0.66 $mh:0.66, $?:class (org.gnome.eog)"

            "suppress_event maximize"
        ];
    };

};}
