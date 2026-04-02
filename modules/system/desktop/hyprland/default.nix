{ config, lib, inputs, pkgs, user, ... }: let
    option = config.modules.system.desktop.hyprland;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.system.desktop.hyprland = {
    enable = lib.mkOption { type = lib.types.bool; default = false; };

    monitors = lib.mkOption { type = lib.types.listOf lib.types.str; default = []; };
    extraConfig = lib.mkOption { type = lib.types.attrs; default = {}; };
    
    animations.enable = lib.mkOption { type = lib.types.bool; default = true; };

    opacity = {
        enable = lib.mkOption { type = lib.types.bool; default = true; };

        value = lib.mkOption { type = lib.types.float; default = 0.9; };
    };

    hypridle = {
        enable = lib.mkOption { type = lib.types.bool; default = true; };

        onBatteryOnly = lib.mkOption { type = lib.types.bool; default = true; };
        kbdDevice = lib.mkOption { type = lib.types.str; default = ""; };

        timeouts = {
            lock = lib.mkOption { type = lib.types.int; default = 600; };
            offScreen = lib.mkOption { type = lib.types.int; default = 900; };
            suspend = lib.mkOption { type = lib.types.int; default = 1500; };
        };

    };
    
    waybar = {
        float = lib.mkOption { type = lib.types.bool; default = true; };
        position = lib.mkOption { type = lib.types.str; default = "top"; };
        width = lib.mkOption { type = lib.types.addCheck lib.types.int (v: v == 0 || v >= 1400); default = 0; };
        opacity = lib.mkOption { type = lib.types.bool; default = option.opacity.enable; };
    };

    record.codec = lib.mkOption { type = lib.types.str; default = "libx264"; };

    showErrors = lib.mkOption { type = lib.types.bool; default = false; };
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    modules.system.boot.tuigreet.cmd = lib.mkDefault "start-hyprland";

home-manager.sharedModules = [{

    imports = [
        ./config/appearance.nix
        ./config/autostart.nix
        ./config/binds.nix
        ./config/other.nix
        ./config/windowrules.nix

        ./modules/animations.nix
        ./modules/hypridle.nix
        ./modules/opacity.nix

        ./scripts/wallpaper.nix

        ./waybar
        ./dunst.nix
        ./pyprland.nix
        ./hyprlock.nix
    ];

    wayland.windowManager.hyprland = {
        enable = true;

        plugins = [
            inputs.hyprsplit.packages.${pkgs.stdenv.hostPlatform.system}.hyprsplit
        ];

        settings = lib.recursiveUpdate {
            monitor = option.monitors;
            plugin = {
                hyprsplit = {
                    num_workspaces = 9;
                    persistent_workspaces = true;
                };
            };
            misc = {
                disable_hyprland_logo = true;
                background_color = lib.mkForce "rgb(000000)";
            };
            debug = {
                suppress_errors = !option.showErrors;
            };
        } option.extraConfig;

        package = null;
        portalPackage = null;
    };

    modules.home.firefox.hideNavigation = true;

}];};}
