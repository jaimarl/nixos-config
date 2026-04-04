{ pkgs, stable, ... }: {

    home.packages = with pkgs; [
        ripgrep
        android-tools
        gowall

        surge-dm

        qbittorrent
        telegram-desktop
        eog

        p7zip
        mediainfo
        trash-cli
        wl-clipboard

        neovim
        luajitPackages.luarocks_bootstrap
        tree-sitter
        gcc
        lua-language-server
        vscode-langservers-extracted
        marksman
    ];

    programs = {
        fzf.enable = true;
        eza.enable = true;
        bat.enable = true;

        btop.enable = true;
        yazi.enable = true;
    };

}
