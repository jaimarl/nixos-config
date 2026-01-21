{ pkgs, host, ... }: {
    programs.zsh.enable = true;
    programs.starship.enable = true;
    users.defaultUserShell = pkgs.zsh;

    environment.shellAliases = {
        switch = "sudo nixos-rebuild switch --flake ~/.nixos/#${host}";
    };
}
