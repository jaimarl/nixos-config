{ config, osConfig, lib, pkgs, ... }: let
    flavor = "mocha";
    accent = "mauve";
in {
options.modules.home.catppuccin.enable = lib.mkEnableOption "Catppuccin Theme";

config = lib.mkIf config.modules.home.catppuccin.enable {

    catppuccin.enable = true;
    catppuccin.flavor = flavor;
    catppuccin.accent = accent;
    
    # Steam
    home = lib.mkIf osConfig.modules.system.gaming.enable ( let
        theme = if flavor == "latte" then "frappe" else flavor;
    in {
        packages = [ pkgs.adwsteamgtk ];
        activation.steamTheme = "${pkgs.adwsteamgtk}/bin/adwaita-steam-gtk -i -o 'color_theme:catppuccin-${theme};win_controls_layout:None'";
    });
    
    # Firefox
    catppuccin.firefox.force = true;
    programs.firefox.profiles.default.settings = {
        "ui.systemUsesDarkTheme" = if flavor == "latte" then 0 else 1;
        "layout.css.prefers-color-scheme.content-override" = if flavor == "latte" then 1 else 0;
    };

};}
