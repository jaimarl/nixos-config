{ pkgs, ... }: {

    home.packages = with pkgs; [
        ripgrep
        fd
        android-tools
        gowall

        qbittorrent
        telegram-desktop
        eog
        prismlauncher

        # Yazi
        p7zip
        mediainfo
        trash-cli
        wl-clipboard

        # Nvim
        neovim
        luajitPackages.luarocks_bootstrap
        tree-sitter
        gcc
        lua-language-server
        vscode-langservers-extracted
        marksman
        nixd
    ];

    programs = {
        fzf.enable = true;
        zoxide.enable = true;
        eza.enable = true;
        bat.enable = true;

        btop.enable = true;
        yazi.enable = true;
        obsidian.enable = true;
    };

}
