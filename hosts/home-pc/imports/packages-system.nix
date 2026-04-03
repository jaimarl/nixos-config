{ pkgs, stable, ... }: {

    boot.kernelPackages = pkgs.linuxPackages_latest;

    environment.systemPackages = with pkgs; [
        # CLI Utils
        android-tools
        
        # TUI Utils
        nvtopPackages.nvidia
    ];

    programs = {
        zsh.enable = true;
        starship.enable = true;
    };

}
