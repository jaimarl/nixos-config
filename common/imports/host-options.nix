{ config, lib, user, ... }: {

    # System Options
    options.host.system = {
        hostname = lib.mkOption { type = lib.types.str; default = "nixos"; };
        locale = lib.mkOption { type = lib.types.str; default = "ru_RU.UTF-8"; };
        timeZone = lib.mkOption { type = lib.types.str; default = "Europe/Moscow"; };

        hasBattery = lib.mkOption { type = lib.types.bool; default = false; };
    };

config.home-manager.users.${user} = {

    # Home Options
    options.host.home = {
        paths = {
            wallpapers = lib.mkOption { type = lib.types.str; default = "$HOME/Pictures/Wallpapers"; };
            screenshots = lib.mkOption { type = lib.types.str; default = "$HOME/Pictures/Screenshots"; };
            records = lib.mkOption { type = lib.types.str; default = "$HOME/Videos/Records"; };
        };
    };

};}
