{ config, lib, inputs, pkgs, user, ... }: let
    option = config.modules.system.wm.hyprland;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.system.wm.hyprland = {
    enable = lib.mkEnableOption "Hyprland WM";

    monitors = lib.mkOption { type = lib.types.listOf lib.types.str; default = []; };
    opacity = {
        enable = lib.mkOption { type = lib.types.bool; default = true; };

        value = lib.mkOption { type = lib.types.float; default = 0.9; };
        extraRules = lib.mkOption { type = lib.types.listOf lib.types.str; default = []; };
    };
    waybar = {
        float = lib.mkOption { type = lib.types.bool; default = true; };
        position = lib.mkOption { type = lib.types.str; default = "top"; };
        width = lib.mkOption { type = lib.types.ints.positive; default = 1; };
        opacity = lib.mkOption { type = lib.types.bool; default = option.opacity.enable; };
    };
};


#--- [ Config ]------------------------------------------------------
config = lib.mkIf option.enable {

    nix.settings = {
        substituters = ["https://hyprland.cachix.org"];
        trusted-substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    modules.system.boot.tuigreet.cmd = "start-hyprland";

    xdg.portal = {
        config = {
            hyprland.default = ["gtk" "hyprland"];
        };
        extraPortals = [
            pkgs.xdg-desktop-portal-gtk
        ];
    };

home-manager.users.${user} = {

    imports = [
        ./appearance.nix
        ./autostart.nix
        ./binds.nix
        ./other.nix
        ./modules/opacity.nix
        ./pyprland.nix
        ./waybar
    ];

    # Packages
    home.packages = with pkgs; [
        polkit_gnome
        hyprland-per-window-layout
        pyprland
        hyprshot
        hyprpicker
        wl-clipboard
        swww
        waybar
    ];

    wayland.windowManager.hyprland = {
        enable = true;
        package = null;
        portalPackage = null;
        plugins = [
            inputs.hyprsplit.packages.${pkgs.stdenv.hostPlatform.system}.hyprsplit
        ];
        settings = {
            monitor = option.monitors;
            plugin = {
                hyprsplit = {
                    num_workspaces = 9;
                    persistent_workspaces = true;
                };
            };
        };
    };

    modules.home.firefox.hideNavigation = true;

};};}
