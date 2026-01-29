{ config, lib, pkgs, user, ... }: {
options.modules.system.shell.zsh.enable = lib.mkEnableOption "Zsh Shell";

config = lib.mkIf config.modules.system.shell.zsh.enable {

    programs.zsh.enable = true;
    programs.starship.enable = true;
    users.defaultUserShell = pkgs.zsh;

    home-manager.users.${user} = {
        programs.fzf.enableZshIntegration = true;
    };

};}
