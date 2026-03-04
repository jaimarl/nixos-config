{ config, osConfig, lib, pkgs, stateVersion, user, ... }: let enabledModules = {
    modules.home = {
        # Enable Modules
        stylix.enable = true;
        firefox.enable = true;
        git.enable = true;
    };}; in {

    imports = [
        ./imports/packages-home.nix
        ../modules/home/.imports.nix
    ];

config = lib.recursiveUpdate enabledModules {

    # Options

#--------------------------------------------------------------------
    home = {
        username = user;
        homeDirectory = "/home/${user}";
        stateVersion = stateVersion;
    };
};}
