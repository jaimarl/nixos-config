{ pkgs, stable, ... }: {

    environment.systemPackages = with pkgs; [
        # TUI Utils
        nvtopPackages.amd 
    ];

    programs = {
        starship.enable = true;
    };

}
