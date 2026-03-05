{ config, lib, pkgs, user, ... }: let
    option = config.modules.system.shell.zsh;
in {

#--- [ Options ] ---------------------------------------------------- 
options.modules.system.shell.zsh = {
    enable = lib.mkEnableOption "Zsh Shell";
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    global.system.shell = "zsh";

};}
