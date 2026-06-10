{ config, lib, ... }: let
    option = config.modules.home.desktop.niri;
in {

#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    modules.home.desktop.niri.configLines = ''
        window-rule {
            open-maximized-to-edges false
            open-fullscreen false
        }


        // Common
        window-rule {
            match app-id="xdg-desktop-portal-gtk"
            match app-id="satty" title="Save Image As"
            open-floating true
            default-column-width { proportion 0.66; }
            default-window-height { proportion 0.75; }
        }
        window-rule {
            match app-id="org.gnome.eog"
            open-floating true
            default-column-width { proportion 0.66; }
            default-window-height { proportion 0.66; }
        }
        window-rule {
            match app-id="org.telegram.desktop" title="Просмотр медиа"
            match app-id="com.gabm.satty"
            opacity 1.0
            open-floating true
            default-column-width { proportion 0.66; }
            default-window-height { proportion 0.66; }
        }


        window-rule {
            match app-id="zen-twilight|zen-beta|firefox"
            match app-id="Spotify"
            match app-id="obsidian"
            open-maximized true
        }


        // Steam
        window-rule {
            match app-id="steam" title="Steam"
            open-maximized true
        }
        window-rule {
            match app-id="steam" title="Настройки"
            open-floating true
        }
        window-rule {
            match app-id="steam" title="Steam — браузер"
            open-floating true
            default-column-width { proportion 0.66; }
            default-window-height { proportion 0.66; }
        }
        window-rule {
            match app-id="steam" title="Список друзей"
            open-floating true
            default-column-width { proportion 0.25; }
            default-window-height { proportion 0.75; }
        }
        window-rule {
            match app-id="steam" title="Добавить стороннюю игру"
            open-floating true
            default-column-width { proportion 0.45; }
            default-window-height { proportion 0.66; }
        }
    '';

};}
