{ config, pkgs, stateVersion, user, ... }: let module = ../modules/home; in {
    imports = [
        ./imports/programs.nix
    ] ++ (map (name: module + "/${name}.nix") [
        "firefox"
        "git"
    ]);

    home = {
        username = user;
        homeDirectory = "/home/${user}";
        stateVersion = stateVersion;
    };
}
