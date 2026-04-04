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
        hostname = "nix-home";
    };


    #--- Modules --------------------------------
    core = {
        audio.monoPlayback.enable = true;
        bootloader.useGrub = true;
        graphics.nvidia.enable = true;
    };

    modules.system = {
        steam.enable = true;
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

};}
