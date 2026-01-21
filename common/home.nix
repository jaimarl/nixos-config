{ config, pkgs, stateVersion, user, ... }: {
    imports = [
        ../modules/home/firefox.nix
        ../modules/home/git.nix
    ];

    home = {
        username = user;
        homeDirectory = "/home/${user}";
        stateVersion = stateVersion;
    };
}
