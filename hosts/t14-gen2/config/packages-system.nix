{ pkgs, stable, ... }: {

    boot.kernelPackages = pkgs.linuxPackages_latest;

    environment.systemPackages = with pkgs; [
        nvtopPackages.amd 
    ];

    programs = {
        zsh.enable = true;
        starship.enable = true;
    };

}
