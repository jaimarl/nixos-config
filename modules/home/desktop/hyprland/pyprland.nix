{ config, osConfig, lib, pkgs, ... }: let
    option = config.modules.home.desktop.hyprland;
in {

#--- [ Config ] -----------------------------------------------------
config = { 
    
    wayland.windowManager.hyprland.settings.exec-once = [
        "${pkgs.pyprland}/bin/pypr"
    ];

    xdg.configFile."pypr/config.toml".text = ''
        [pyprland]
        plugins = [
            "magnify"
        ]
    '';

};}
