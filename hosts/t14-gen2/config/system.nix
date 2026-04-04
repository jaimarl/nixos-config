{ config, hmConfig, lib, pkgs, ... }: let
    hostOption = config.host.system;
in {
    
    imports = [
        ../hardware.nix
        ./packages-system.nix
        ./services.nix
    ];

config = {

    #--- Host Options ---------------------------
    host.system = {
        hostname = "nix-btw";
        hasBattery = true;
    };


    #--- Modules --------------------------------
    core = {
        bootloader.useGrub = true;
        audio.monoPlayback.enable = true;
    };

    modules.system = {
        steam.enable = true;
        virtualisation.enable = true;
        zapret = {
            enable = true;
            strategy = "general(ALT)";
        };
        hardware = {
            wifi.enable = true;
            bluetooth.enable = true;
        };
        boot = {
            tuigreet.enable = true;
            swap.enable = true;
            zram.enable = true;
        };
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

};}
