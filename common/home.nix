{ config, osConfig, lib, pkgs, stateVersion, user, ... }: {

    imports = [
        # Core Modules
        ../modules/core/stylix.nix

        ./imports/packages-home.nix
        ../modules/home
    ];

config = {

    # Options
    programs.git = {
        enable = true;
        settings.user.name = "jaimarl";
        settings.user.email = "jaimarl.me@gmail.com";
    };

#--------------------------------------------------------------------
    home = {
        username = user;
        homeDirectory = "/home/${user}";
        stateVersion = stateVersion;
    };
};}
