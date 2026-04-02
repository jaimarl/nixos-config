{ config, lib, ... }: let
    option = config.modules.home.discord;
    stylix = config.core.stylix;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.home.discord = {
    enable = lib.mkOption { type = lib.types.bool; default = false; };
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    programs.nixcord = {
        enable = true;

        discord.enable = false;
        discord.vencord.enable = false;
        vesktop.enable = true;

        quickCss = "@import url(\"https://catppuccin.github.io/discord/dist/catppuccin-${stylix.flavor}-blue.theme.css\");";

        config = {
            useQuickCss = true;
            plugins = {
                fakeNitro.enable = true;
                volumeBooster.enable = true;
                imageZoom.enable = true;
                shikiCodeblocks.enable = true;
                memberCount.enable = true;
                disableCallIdle.enable = true;
            };
        };
    };

};}
