{ config, osConfig, lib, pkgs, stateVersion, ... }: {

    imports = [
        ./imports/packages-home.nix
    ];
    
config = {

    #--- Host Options ---------------------------
    host.home = {

    };


    #--- Modules --------------------------------
    core.stylix = {

    };

    modules.home = {

    };


    #--- Options --------------------------------

};}
