{ pkgs, stable, ... }: {

    environment.systemPackages = with pkgs; [
        git
        tree
        fastfetch
        brightnessctl

        neovim
        btop
    ];

    programs = {

    };

}
