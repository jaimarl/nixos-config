{ config, osConfig, lib, ... }: {

config = lib.mkIf osConfig.modules.system.wm.hyprland.enable {

    wayland.windowManager.hyprland.settings.exec-once = [
        "waybar"
    ];

    # programs.waybar.enable = true;

};}
