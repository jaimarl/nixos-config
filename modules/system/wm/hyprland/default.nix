{ config, osConfig, lib, pkgs, user, ... }: let
    option = config.modules.system.wm.hyprland;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.system.wm.hyprland = {
    enable = lib.mkEnableOption "Hyprland WM";

    monitors = lib.mkOption { type = lib.types.listOf lib.types.str; default = []; };
    opacity = lib.mkOption { type = lib.types.bool; default = true; };
};


#--- [ Config ]------------------------------------------------------
config = lib.mkIf option.enable {

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
            monitor = option.monitors;
        };
    };

    modules.home.firefox.hideNavigation = true;

};};}
