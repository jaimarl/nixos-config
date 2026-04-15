{ config, osConfig, lib, ... }: let
    option = config.modules.home.desktop.hyprland;
in {

#--- [ Config ] -----------------------------------------------------
config = {

    wayland.windowManager.hyprland.settings = {
        "$?" = "match";
        "$mw:" = "monitor_w*";
        "$mh:" = "monitor_h*";
        "$ww:" = "window_w*";
        "$wh:" = "window_h*";

        "$prism-install" = "center 1, size $mw:0.5 $mh:0.7, $?:class (org.prismlauncher.PrismLauncher), $?:title";

        windowrule = [
            # Floating Windows
            "float 1, fullscreen_state 0, size $mw:0.66 $mh:0.66, $?:class (org.telegram.desktop), $?:title (Просмотр медиа)"
            "float 1, center 1, size $mw:0.6 $mh:0.75, $?:class (xdg-desktop-portal-gtk)"
            "float 1, center 1, size $mw:0.4 $mh:0.5, $?:title (Select what to share)"
            "float 1, size $mw:0.66 $mh:0.66, $?:class (org.gnome.eog)"

            # Picture In Picture
            "float 1, keep_aspect_ratio 1, pin 1, move $mw:0.733 $mh:0.72, size $mw:0.25 $mh:0.25, $?:title (Картинка в картинке)"

            # Prism Launcher
            "$prism-install (Settings.*)"
            "$prism-install (Новый экземпляр.*)"
            "$prism-install (Загрузить моды.*)"
            "$prism-install (Загрузить наборы ресурсов.*)"
            "$prism-install (Загрузить наборы шейдеров.*)"

            # Steam
            "float 1, $?:class (steam), $?:title (Настройки)"
            "float 1, center 1, size $mw:0.66 $mh:0.66, $?:class (steam), $?:title (Steam — браузер)"
            "float 1, center 1, size $mw:0.25 $mh:0.75, $?:class (steam), $?:title (Список друзей)"
            "float 1, center 1, size $mw:0.45 $mh:0.66, $?:class (steam), $?:title (Добавить стороннюю игру)"

            # Other
            "suppress_event maximize"
        ];
        layerrule = [
            "animation slide, $?:namespace waybar"
            "animation slide, $?:namespace notifications"
        ];
    };

};}
