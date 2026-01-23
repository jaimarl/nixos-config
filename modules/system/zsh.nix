{ pkgs, ... }: {
    programs.zsh.enable = true;
    programs.starship.enable = true;
    users.defaultUserShell = pkgs.zsh;
}
