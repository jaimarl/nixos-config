{ config, lib, pkgs, user, ... }: {
options.modules.system.gaming.enable = lib.mkEnableOption "Gaming Launchers & Utils";

config = lib.mkIf config.modules.system.gaming.enable {

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
