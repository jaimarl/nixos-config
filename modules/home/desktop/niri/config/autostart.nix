{ config, lib, pkgs, ... }: let
    option = config.modules.home.desktop.niri;
in {

#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    modules.home.desktop.niri.configLines = ''
        //spawn-at-startup "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        spawn-sh-at-startup "${pkgs.wl-clip-persist}/bin/wl-clip-persist -c regular"
    '';

};}
