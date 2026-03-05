{ config, lib, inputs, pkgs, ... }: let
    option = config.modules.home.stylix;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.home.stylix = {
    enable = lib.mkEnableOption "Stylix Theming";

    theme = lib.mkOption { type = lib.types.str; default = "catppuccin-mocha"; };
    cursor = {
        package = lib.mkOption { type = lib.types.package; default = pkgs.capitaine-cursors-themed; };
        name = lib.mkOption { type = lib.types.str; default = "Capitaine Cursors"; };
    };
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
        noto-fonts
        dejavu_fonts
        liberation_ttf
        nerd-fonts.jetbrains-mono
    ];

    stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/${option.theme}.yaml";

        cursor = {
            package = option.cursor.package;
            name = option.cursor.name;
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
