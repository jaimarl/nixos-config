{ config, lib, pkgs, user, ... }: {
options.modules.system.shell.zsh.enable = lib.mkEnableOption "Zsh Shell";

config = lib.mkIf config.modules.system.shell.zsh.enable {

    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    global.system.shell = "zsh";

};}
