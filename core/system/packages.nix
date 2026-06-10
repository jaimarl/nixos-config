{ pkgs, ... }: {

    environment.systemPackages = with pkgs; [
        git
        neovim
        btop
    ];

    programs = {

    };

}
