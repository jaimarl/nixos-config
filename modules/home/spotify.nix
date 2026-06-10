{ inputs, config, lib, pkgs, ... }: let
    option = config.modules.home.spotify;
    stylix = config.core.stylix;
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {

    imports = [
        inputs.spicetify-nix.homeManagerModules.default 
    ];

#--- [ Options ] ----------------------------------------------------
options.modules.home.spotify = {
    enable = lib.mkOption { type = lib.types.bool; default = false; };
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

        theme = spicePkgs.themes.catppuccin;

        colorScheme = "${stylix.flavor}";
    };
};}
