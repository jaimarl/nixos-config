let
    appsToHide = [

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
