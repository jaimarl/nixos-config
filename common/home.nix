{ config, osConfig, lib, pkgs, stateVersion, user, ... }: let enabledModules = {
    modules.home = {
        # Enable Modules
        stylix.enable = true;
        firefox.enable = true;
    };}; in {

    imports = [
        ./imports/packages-home.nix
        ../modules/home/.imports.nix
    ];

config = lib.recursiveUpdate enabledModules {

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
