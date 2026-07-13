let
    appsToHide = [
        "btop"
        "kvantummanager"
        "nvim"
        "org.gnome.eog"
        "qt5ct"
        "qt6ct"
        "yazi"
        "nixos-manual"
        "nvtop"
        "protontricks"
        "v2raya"
        "syncthing-ui"
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
