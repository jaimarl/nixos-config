{ config, lib, pkgs, ... }: {
config = lib.mkIf config.modules.home.hyprland.enable {

    wayland.windowManager.hyprland.settings.exec-once = [
        "${pkgs.hyprland-per-window-layout}/bin/hyprland-per-window-layout"
        "${pkgs.pyprland}/bin/pypr"
        "${pkgs.swww}/bin/swww-daemon"
    ];

};}
