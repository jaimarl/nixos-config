{ config, osConfig, lib, ... }: let
    option = osConfig.modules.system.desktop.hyprland;
in {

#--- [ Config ] -----------------------------------------------------
config = {
    
    wayland.windowManager.hyprland.settings = {
        animations = {
            enabled = option.animations.enable;
            bezier = [
                "default, 0.05, 0.9, 0.1, 1"
                "wind, 0.05, 0.9, 0.1, 1"
                "overshot, 0.13, 0.99, 0.29, 1"
                "liner, 1, 1, 1, 1"
            ];
            animation = [
                "windows, 1, 3.5, wind, popin"
                "windowsIn, 1, 3.5, overshot, popin"
                "windowsOut, 1, 3.5, overshot, popin"
                "windowsMove, 1, 3.5, overshot, slide"
                "layers, 1, 5, default, popin"
                "fadeIn, 1, 10, default"
                "fadeOut, 1, 10, default"
                "fadeSwitch, 1, 10, default"
                "fadeShadow, 1, 10, default"
                "fadeDim, 1, 10, default"
                "fadeLayers, 1, 10, default"
                "workspaces, 1, 4, overshot, slide"
                "specialWorkspace, 1, 4, overshot, slidevert"
                "border, 1, 1, liner"
                "borderangle, 1, 30, liner, loop"
            ];
        };
        layerrule = [
            "no_anim true, match:namespace (awww-daemon)"
            "no_anim true, match:namespace (hyprpicker)"
            "no_anim true, match:namespace (selection)"
        ];
    };

};}
