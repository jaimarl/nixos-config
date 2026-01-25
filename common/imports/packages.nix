{ pkgs, ... }: {
    boot.kernelPackages = pkgs.linuxPackages_latest;
    nixpkgs.config = {
        allowUnfree = true;
        permittedInsecurePackages = [  ];
    };

    fonts.packages = with pkgs; [
        terminus_font
        noto-fonts
        noto-fonts-color-emoji
        dejavu_fonts
        liberation_ttf
        nerd-fonts.jetbrains-mono
    ];

    environment.systemPackages = with pkgs; [
        # CLI Utils
        git
        tree
        jq
        p7zip
        mediainfo
        trash-cli
        brightnessctl
        fastfetch
        
        # TUI Utils
        # nvtopPackages.full
        neovim
            luajitPackages.luarocks_bootstrap
    ];
}
