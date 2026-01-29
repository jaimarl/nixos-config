{ config, lib, ... }: {
config = lib.mkIf config.modules.home.hyprland.enable {

    xdg.configFile."hypr/pyprland.toml".text = ''
        [pyprland]
        plugins = [
            "magnify"
        ]
    '';

};}
