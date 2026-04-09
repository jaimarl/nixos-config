{ config, lib, pkgs, stateVersion, ... }: {

    #--- Host Options ---------------------------
    host.home = {

    };


    #--- Modules --------------------------------
    core.stylix = {

    };

    modules.home = {
        kitty.enable = true;
        firefox.enable = true;
        spotify.enable = true;
        dunst.enable = true;
        desktop.hyprland = {
            enable = true;
            opacity.enable = false;

            monitors = [ "eDP-1, 1920x1080@60, 0x0, 1" ];
            hypridle.kbdDevice = "tpacpi::kbd_backlight";
            record.codec = "hevc_vaapi";

            extraConfig = {
                general = {
                    layout = "master";
                };
                windowrule = [
                    "workspace 9, match:class (spotify)"
                ];
                bind = [
                    ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                    ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
                ];
                binde = [
                    ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
                    ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 2%+"

                    ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
                    ", XF86MonBrightnessUp, exec, brightnessctl s 5%+"

                    "Super, Backslash, togglespecialworkspace, surge"
                ];
                exec-once = [
                    "[workspace special:surge silent] kitty surge"
                ];
            };
        };
    };


    #--- Options --------------------------------
    programs.git = {
        enable = true;
        settings.user.name = "jaimarl";
        settings.user.email = "jaimarl.me@gmail.com";
    };

}
