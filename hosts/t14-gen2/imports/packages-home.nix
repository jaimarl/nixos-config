{ pkgs, ... }: {

    home.packages = with pkgs; [
        # TUI Utils
        nvtopPackages.amd 
    ];

    programs = {

    };

}
