{ config, lib, pkgs, user, ... }: {
options.modules.system.wm.hyprland.enable = lib.mkEnableOption "Hyprland WM";

options.modules.system.wm.hyprland = {
    monitors = lib.mkOption { type = lib.types.listOf lib.types.str; default = []; };
    opacity = lib.mkOption { type = lib.types.bool; default = true; };
};

config = lib.mkIf config.modules.system.wm.hyprland.enable {

    programs.hyprland.enable = true;
    modules.system.boot.tuigreet.cmd = "start-hyprland";
    
home-manager.users.${user} = {

    imports = [
        ./appearance.nix
        ./autostart.nix
        ./binds.nix
        ./other.nix
        ./modules/opacity.nix
        ./pyprland.nix
        ./waybar.nix
    ];

    # Packages
    home.packages = with pkgs; [
        hyprland-per-window-layout
        pyprland
        polkit_gnome
        wl-clipboard
        waybar
        swww
    ];

    wayland.windowManager.hyprland = {
        enable = true;
        settings = {
            monitor = config.modules.system.wm.hyprland.monitors;
        };
    };

    modules.home.kitty.enable = true;

    modules.home.firefox.hideNavigation = true;

};};}
