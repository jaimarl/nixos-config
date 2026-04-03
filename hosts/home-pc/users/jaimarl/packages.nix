{ pkgs, stable, ... }: {

    home.packages = with pkgs; [
        # CLI Utils
        ripgrep
        gowall

        # GUI Apps
        qbittorrent
        telegram-desktop
        eog

        # Yazi Requirements 
        p7zip
        mediainfo
        trash-cli
        wl-clipboard

        # Neovim
        neovim
        luajitPackages.luarocks_bootstrap
        tree-sitter
        gcc
        lua-language-server
        vscode-langservers-extracted
        marksman
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
