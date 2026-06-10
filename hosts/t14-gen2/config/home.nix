{ config, ... }: {

    imports = [
        ./packages-home.nix
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
