{ inputs, config, lib, pkgs, ... }: let
    option = config.modules.home.spotify;
    stylix = config.modules.core.stylix;
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {

#--- [ Options ] ----------------------------------------------------
options.modules.home.spotify = {
    enable = lib.mkEnableOption "Spotify";
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    programs.spicetify = {
        enable = true;

        enabledExtensions = with spicePkgs.extensions; [
            adblock
            {
                name = "beautiful-fullscreen.js";
                src = "${pkgs.fetchFromGitHub {
                    owner = "Oein";
                    repo = "beautifulfullscreen";
                    rev = "b40f1346db32c1e63cfccc5eb384b549d165d0e4";
                    hash = "sha256-/lNDi6J9WEFyQFOJzKQ1fTzh2RrTZZyuIWOVcKH6DJw=";
                }}/dist";
            }
        ];

        enabledCustomApps = with spicePkgs.apps; [
            lyricsPlus
        ];

        theme =
            if stylix.themeOverride.spotify.theme != ""
                then spicePkgs.themes.${stylix.themeOverride.spotify.theme}
            else lib.mkDefault spicePkgs.themes.catppuccin;

        colorScheme = 
            if stylix.themeOverride.spotify.colorScheme != ""
                then stylix.themeOverride.spotify.colorScheme
            else if stylix.themeOverride.base16 == "" && stylix.themeOverride.spotify.theme == ""
                then lib.mkDefault "${stylix.catppuccin.flavor}"
            else lib.mkDefault "";
    };
};}
