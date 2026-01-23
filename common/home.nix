{ config, pkgs, stateVersion, user, ... }: let module = ../modules/home; in {
    imports = [] ++ (map (name: module + "/${name}.nix") [
        # Modules
        "firefox"
        "git"
        "hyprland"
    ]);

    home = {
        username = user;
        homeDirectory = "/home/${user}";
        stateVersion = stateVersion;
    };
}
