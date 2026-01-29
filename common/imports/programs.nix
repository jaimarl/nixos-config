{ pkgs, ... }: {
    home.packages = with pkgs; [
        # CLI Utils
        p7zip
        mediainfo
        trash-cli
    ];

    # CLI Utils
    programs.bat.enable = true;
    programs.eza.enable = true;
    programs.fzf.enable = true;

    # TUI Utils
    programs.btop.enable = true;
    programs.yazi.enable = true;
}
