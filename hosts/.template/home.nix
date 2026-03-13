{ config, osConfig, lib, pkgs, stateVersion, user, ... }: {

    imports = [
        ./imports/packages-home.nix
    ];
    
config = {

    # Set Host Options
    host.home = {
        # Configure paths and options here
        # For options list check common/imports/host-options.nix
    };

    # Enable & Configure Modules
    modules.core.stylix = {
        # Theme overrides
    };

    modules.home = {

    };

#--------------------------------------------------------------------
    home = {
        username = user;
        homeDirectory = "/home/${user}";
        stateVersion = stateVersion;
    };
};}
