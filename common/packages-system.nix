{ pkgs, stable, ... }: {

    environment.systemPackages = with pkgs; [
        git
        tree
        fastfetch

        neovim
        btop
    ];

    programs = {

    };

}
