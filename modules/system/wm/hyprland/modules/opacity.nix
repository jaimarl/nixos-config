{ osConfig, lib, ... }: {

config = lib.mkIf osConfig.modules.system.wm.hyprland.opacity {
    
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
