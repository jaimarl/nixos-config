{ config, osConfig, lib, ... }: let
    option = osConfig.modules.system.wm.hyprland;
in {

#--- [ Config ] -----------------------------------------------------
config = { 
    
    wayland.windowManager.hyprland.settings.exec-once = [
        "pypr"
    ];

    xdg.configFile."pypr/config.toml".text = ''
        [pyprland]
        plugins = [
            "magnify"
        ]
    '';

};}
