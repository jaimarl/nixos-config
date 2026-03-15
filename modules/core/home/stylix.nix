{ config, lib, inputs, pkgs, ... }: let
    option = config.modules.core.stylix;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.core.stylix = {
    flavor = lib.mkOption { type = lib.types.str; default = "macchiato"; };

    cursor = {
        package = lib.mkOption { type = lib.types.package; default = pkgs.capitaine-cursors-themed; };
        name = lib.mkOption { type = lib.types.str; default = "Capitaine Cursors"; };
    };
};


#--- [ Config ] -----------------------------------------------------
config = {

    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        dejavu_fonts
        liberation_ttf
        nerd-fonts.jetbrains-mono
    ];

    stylix = {
        enable = true;

        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-${option.flavor}.yaml";

        polarity = if option.flavor == "latte" then "light" else "dark";

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
                desktop = 11;
                terminal = 11;
            };
        };

        targets.waybar.enable = false;
        targets.dunst.enable = false;
        targets.hyprlock.enable = false;
        targets.spicetify.enable = false;
        targets.nixcord.enable = false;

        targets.firefox.colorTheme.enable = true;
        targets.firefox.profileNames = [ "default" ];
    };

};}
