{ inputs, pkgs, ... }: {

    boot.kernelPackages = pkgs.linuxPackages_latest;
    nixpkgs.config = {
        allowUnfree = true;
        permittedInsecurePackages = [  ];
    };

    environment.systemPackages = with pkgs; [
        # CLI Utils
        git
        tree
        ripgrep
        jq
        fd
        fastfetch
        brightnessctl
        
        # TUI Utils
        neovim luajitPackages.luarocks_bootstrap tree-sitter gcc lua-language-server marksman
    ];

    programs = {

    };

}
