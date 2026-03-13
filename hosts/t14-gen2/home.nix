{ config, osConfig, lib, pkgs, stateVersion, user, ... }: {

    imports = [
        ./imports/packages-home.nix
    ];
    
config = {

    # Set Host Options
    host.home = {

    };

    # Enable & Configure Modules
    modules.core.stylix = {

    };

    modules.home = {
        kitty.enable = true;
        firefox.enable = true;
        spotify.enable = true;
    };

#--------------------------------------------------------------------
    home = {
        username = user;
        homeDirectory = "/home/${user}";
        stateVersion = stateVersion;
    };
};}
