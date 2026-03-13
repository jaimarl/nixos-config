{ config, lib, pkgs, user, ... }: let
    option = config.modules.system.gaming;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.system.gaming = {
    enable = lib.mkOption { type = lib.types.bool; default = false; };

    mangohud.sessionWide = lib.mkEnableOption "Auto MangoHud overlay in supported apps";
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    environment.systemPackages = with pkgs; [
        prismlauncher
        heroic
    ];

    programs.gamemode.enable = true;
    programs.steam = {
        enable = true;
        protontricks.enable = true;
        gamescopeSession.enable = true;
    };

    home-manager.users.${user} = {
        programs.mangohud.enable = true;
    };

};}
