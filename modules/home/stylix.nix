{ config, lib, inputs, pkgs, ... }: {
options.modules.home.stylix.enable = lib.mkEnableOption "Stylix Theming";

config = lib.mkIf config.modules.home.stylix.enable {

    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
        noto-fonts
        dejavu_fonts
        liberation_ttf
        nerd-fonts.jetbrains-mono
    ];

    stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

        cursor = {
            package = pkgs.capitaine-cursors-themed;
            name = "Capitaine Cursors (Gruvbox)";
            size = 24;
        };

        fonts = {
            serif = {
                package = inputs.apple-fonts.packages.${pkgs.system}.ny;
                name = "New York";
            };
            sansSerif = {
                package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro;
                name = "SF Pro Display";
            };
            monospace = {
                package = inputs.apple-fonts.packages.${pkgs.system}.sf-mono;
                name = "SF Mono";
            };
            emoji = {
                package = pkgs.noto-fonts-color-emoji;
                name = "Noto Color Emoji";
            };
            sizes = {
                applications = 12;
                terminal = 11;
            };
        };

        targets.firefox.colorTheme.enable = true;
        targets.firefox.profileNames = [ "default" ];
    };

};}
