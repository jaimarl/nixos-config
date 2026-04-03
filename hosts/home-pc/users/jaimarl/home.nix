{ config, lib, pkgs, stateVersion, ... }: {

    #--- Host Options ---------------------------
    host.home = {

    };


    #--- Modules --------------------------------
    core.stylix = {

    };

    modules.home = {
        kitty.enable = true;
        firefox.enable = true;
        spotify.enable = true;
        discord.enable = true;
    };


    #--- Options --------------------------------
    programs.git = {
        enable = true;
        settings.user.name = "jaimarl";
        settings.user.email = "jaimarl.me@gmail.com";
    };

}
