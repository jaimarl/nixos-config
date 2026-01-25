{ pkgs, user, ... }: {
    environment.systemPackages = with pkgs; [
        heroic
        mangohud
    ];

    programs.gamemode.enable = true;
    programs.steam = {
        enable = true;
        protontricks.enable = true;
        gamescopeSession.enable = true;
    };
}
