{ config, pkgs, stateVersion, user, ... }: let module = ../../modules/home; in {
    imports = [] ++ (map (name: module + "/${name}.nix") [
        # Modules
        "catppuccin"
    ]);

    disabledModules = [] ++ (map (name: module + "/${name}.nix") [

    ]);

    home = {
        username = user;
        homeDirectory = "/home/${user}";
        stateVersion = stateVersion;
    };
}
