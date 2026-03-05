{ config, lib, pkgs, user, ... }: let
    option = config.modules.system.gaming;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.system.gaming = {
    enable = lib.mkEnableOption "Gaming Launchers & Utils";
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    environment.systemPackages = with pkgs; [
        prismlauncher
        heroic
        mangohud
    ];

    programs.gamemode.enable = true;
    programs.steam = {
        enable = true;
        protontricks.enable = true;
        gamescopeSession.enable = true;
    };

};}
