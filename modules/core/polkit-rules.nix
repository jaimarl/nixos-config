{ config, lib, pkgs, ... }: let
    option = config.modules.core.polkitRules;
in {

#--- [ Options ] ---------------------------------------------------- 
options.modules.core.polkitRules = {
    power.enable = lib.mkOption { type = lib.types.bool; default = true; };
};


#--- [ Config ] -----------------------------------------------------
config = {

    security.polkit.extraConfig = lib.mkIf option.power.enable ''
        if (( action.id == "org.freedesktop.login1.reboot" || \
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" || \
            action.id == "org.freedesktop.login1.power-off" || \
            action.id == "org.freedesktop.login1.power-off-multiple-sessions" && \
            subject.isInGroup("wheel")) { return polkit.Result.YES; }
        );
    '';

};}
