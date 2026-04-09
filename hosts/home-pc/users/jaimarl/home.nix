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
        discord.enable = true;
        dunst.enable = true;
        desktop.hyprland = {
            enable = true;
            hypridle.enable = false;

            monitors = [ "DP-3, 1920x1080@144, 0x0, 1" "HDMI-A-1, 1920x1080@60, 1920x0, 1" ];
            record.codec = "h264_nvenc";

            extraConfig = {
                general = {
                    layout = "master";
                };
                windowrule = [
                    "workspace 9, match:class (spotify)"
                ];
                bind = [
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
