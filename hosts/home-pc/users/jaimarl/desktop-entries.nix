let
    appsToHide = [
        "btop"
        "nvim"
        "nixos-manual"
        "nvtop"
        "protontricks"
        "v2raya"
        "yazi"
        "qt5ct"
        "qt6ct"
        "kvantummanager"
        "org.gnome.eog"
    ];
in {

    xdg.desktopEntries = builtins.listToAttrs (map (name: {
        inherit name;
        value = {
            name = name;
            exec = "true"; 
            noDisplay = true;
        };
    }) appsToHide);

}
