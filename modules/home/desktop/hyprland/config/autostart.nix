{ config, osConfig, lib, pkgs, ... }: let
    option = config.modules.home.desktop.hyprland;
    stylix = config.core.stylix;

    awww = pkgs.writeShellScript "start" ''
        WALL_DIR="${config.host.home.paths.wallpapers}"
        ALL_WALLS=$(find "$WALL_DIR" -type f | grep -E "\.(jpg|jpeg|png|webp|gif)$")

        if [ -L "$HOME/.cache/wallpaper/current.png" ]; then
            wp set "$HOME/.cache/wallpaper/current.png"
        else
            if [ -n "$ALL_WALLS" ]; then
                wp random
            else
                wp set /etc/nixos/assets/wallpapers/catppuccin-${stylix.flavor}.png
            fi
        fi;
    '';
in {

#--- [ Config ] -----------------------------------------------------
config = {

    wayland.windowManager.hyprland.settings = {
        exec-once = [
            "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
            "${pkgs.hyprland-per-window-layout}/bin/hyprland-per-window-layout"
            "${pkgs.wl-clip-persist}/bin/wl-clip-persist -c regular"
            "${awww}"
        ];
    };

};}
