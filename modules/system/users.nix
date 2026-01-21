{ pkgs, ... }: {
    programs.zsh.enable = true;
    programs.starship.enable = true;

    users = {
        defaultUserShell = pkgs.zsh;

        users.jaimarl = {
            isNormalUser = true;
            extraGroups = [ "wheel" "power" ];
            packages = with pkgs; [  ];
        };
    };
}
