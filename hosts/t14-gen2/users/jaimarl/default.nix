{ pkgs, ... }: {

    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;

}
