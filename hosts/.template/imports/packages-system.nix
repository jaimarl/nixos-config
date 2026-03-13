{ pkgs, stable, ... }: {
    
    # Comment to use stable kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # System-wide packages
    environment.systemPackages = with pkgs; [
        # TUI Utils
        nvtopPackages.amd 
    ];

    programs = {
        starship.enable = true;
    };

}
