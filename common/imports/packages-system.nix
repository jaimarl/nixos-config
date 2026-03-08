{ pkgs, stable, ... }: {

    boot.kernelPackages = pkgs.linuxPackages_latest;

    environment.systemPackages = with pkgs; [
        # CLI Utils
        nvd
        git
        tree
        jq
        fd
        ripgrep
        fastfetch
        brightnessctl

        # TUI Utils
        neovim
    ];

    programs = {

    };

}
