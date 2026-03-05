{ config, osConfig, lib, ... }: let
    option = osConfig.modules.system.wm.hyprland;
in {

#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.opacity {
    
    wayland.windowManager.hyprland.settings = {
        windowrule = [
            "opacity 0.85, match:class (.*)"

            "opacity 1, match:class (firefox), match:title (.*YouTube — Mozilla Firefox)"
            "opacity 1, match:class (firefox), match:title (.*Twitch — Mozilla Firefox)"

            "opacity 1, match:fullscreen true"
        ];
        layerrule = [
            "blur true, match:namespace (waybar)"
        ];
    };

};}
