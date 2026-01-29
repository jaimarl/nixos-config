{ config, lib, pkgs, stateVersion, user, ... }: let enabledModules = {
    modules.home = {
        # Enable Modules
    };}; in {

    imports = [
        ./imports/programs.nix
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
