{ pkgs, user, ... }: {
    programs.zsh.enable = true;
    programs.starship.enable = true;
    users.defaultUserShell = pkgs.zsh;

    home-manager.users.${user} = {
        programs.fzf.enableZshIntegration = true;
    };
}
