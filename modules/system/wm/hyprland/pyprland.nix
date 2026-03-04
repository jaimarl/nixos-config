{ config, lib, ... }: {
    
    wayland.windowManager.hyprland.settings.exec-once = [
        "pypr"
    ];

    xdg.configFile."hypr/pyprland.toml".text = ''
        [pyprland]
        plugins = [
            "magnify"
        ]
    '';

}
