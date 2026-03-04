{ pkgs, ... }: {

    environment.systemPackages = with pkgs; [

    ];

    programs = {
        starship.enable = true;
    };

}
