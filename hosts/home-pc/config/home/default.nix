{ config, ... }: {

    imports = [
        ./packages.nix
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
