{ config, lib, user, ... }: {

    # System Options
    options.global.system.shell = lib.mkOption { type = lib.types.str; default = "bash"; };

config.home-manager.users.${user} = {

    # Home Manager Options
    options.global.home.terminal = lib.mkOption { type = lib.types.str; default = ""; };

};}
