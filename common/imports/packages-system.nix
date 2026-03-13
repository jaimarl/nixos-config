{ pkgs, stable, user, ... }: {

    environment.systemPackages = with pkgs; [
        # CLI Utils
        git
        tree
        fastfetch
        brightnessctl

        # TUI Utils
        neovim
        btop
    ];

    programs = {

    };

}
