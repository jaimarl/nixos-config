{ pkgs, stable, ... }: {

    boot.kernelPackages = pkgs.linuxPackages_zen;

    environment.systemPackages = with pkgs; [
        nvtopPackages.nvidia
    ];

    programs = {
        zsh.enable = true;
        starship.enable = true;
    };

}
