{ config, pkgs, stateVersion, user, ... }: {
    imports = [

    ];

    home = {
        username = user;
        homeDirectory = "/home/${user}";
        stateVersion = stateVersion;
    };
}
