{ config, osConfig, lib, ... }: let
    option = osConfig.modules.system.wm.hyprland;
in {

#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.opacity.enable {
    
    wayland.windowManager.hyprland.settings = {
        windowrule = [
            "opacity ${toString option.opacity.value}, match:class (.*)"

            "opacity 1, match:class (firefox), match:title (.*YouTube — Mozilla Firefox)"
            "opacity 1, match:class (firefox), match:title (.*Twitch — Mozilla Firefox)"

            "opacity 1, match:fullscreen true"
        ] ++ option.opacity.extraRules;
        layerrule = [
            "blur true, match:namespace (waybar)"
        ];
    };

};}
