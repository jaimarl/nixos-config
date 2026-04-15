{ pkgs, stable, ... }: {

    environment.systemPackages = with pkgs; [
        git
        tree
        neovim
        btop
    ];

    programs = {

    };

}
