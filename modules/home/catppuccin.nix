let
    flavor = "mocha";
    accent = "mauve";
in {
    catppuccin.enable = true;
    catppuccin.flavor = flavor;
    catppuccin.accent = accent;
    
    catppuccin.firefox.force = true;
    programs.firefox.profiles.default.settings = {
        "ui.systemUsesDarkTheme" = if flavor == "latte" then 0 else 1;
        "layout.css.prefers-color-scheme.content-override" = if flavor == "latte" then 1 else 0;
    };
}
