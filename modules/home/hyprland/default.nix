{ config, lib, pkgs, ... }: {
options.modules.home.hyprland.enable = lib.mkEnableOption "Hyprland WM";

    imports = [
        ./pyprland.nix
        ./appearance.nix
        ./autostart.nix
        ./binds.nix
        ./other.nix

        ../kitty.nix
    ];

config = lib.mkIf config.modules.home.hyprland.enable {

    # Packages
    home.packages = with pkgs; [
        hyprland-per-window-layout
        pyprland
        kitty
        swww
        wl-clipboard
    ];

    wayland.windowManager.hyprland.enable = true;
    modules.home.kitty.enable = true;

};}
