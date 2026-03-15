{ pkgs, stable, ... }: {

    boot.kernelPackages = pkgs.linuxPackages_latest;

    environment.systemPackages = with pkgs; [
        # CLI Utils
        android-tools
        
        # TUI Utils
        nvtopPackages.amd 
    ];

    programs = {
        starship.enable = true;
    };

}
