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
        activation.installSoftware = ''
            if [ ! -d ~/.software ]; then
                echo "Installing software..."
                ${pkgs.git}/bin/git clone https://github.com/jaimarl/software ~/.software
                ~/.software/install.sh nvim yazi zsh
            fi
        '';
    };
}
