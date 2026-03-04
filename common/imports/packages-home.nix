{ pkgs, ... }: {

    home.packages = with pkgs; [
        # CLI Utils
        p7zip
        mediainfo
        trash-cli
        gowall
    ];

    programs = {
        # CLI Utils
        fzf.enable = true;
        eza.enable = true;
        bat.enable = true;

        # TUI Utils
        btop.enable = true;
        yazi.enable = true;
    };

}
