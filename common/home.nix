{ config, pkgs, stateVersion, ... }: {
    imports = [
        ../modules/home/git.nix
    ];

    home = {
        username = "jaimarl";
        homeDirectory = "/home/jaimarl";
        stateVersion = stateVersion;
    };
}
