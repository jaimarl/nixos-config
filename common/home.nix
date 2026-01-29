{ config, lib, pkgs, stateVersion, user, ... }: let enabledModules = {
    modules.home = {
        # Enable Modules
        catppuccin.enable = true;
        firefox.enable = true;
        git.enable = true;
    };}; in {

    imports = [
        ./imports/programs.nix
        ../modules/home/.imports.nix
    ];

config = enabledModules // {

    # Options

#--------------------------------------------------------------------
    home = {
        username = user;
        homeDirectory = "/home/${user}";
        stateVersion = stateVersion;
    };
};}
