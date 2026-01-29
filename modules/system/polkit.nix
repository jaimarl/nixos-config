{ config, lib, pkgs, ... }: {
options.modules.system.polkit.enable = lib.mkEnableOption "Polkit Configuration";

config = lib.mkIf config.modules.system.polkit.enable {

    environment.systemPackages = with pkgs; [
        polkit_gnome
    ];

    security.polkit.extraConfig = ''
        if (( action.id == "org.freedesktop.login1.reboot" || \
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" || \
            action.id == "org.freedesktop.login1.power-off" || \
            action.id == "org.freedesktop.login1.power-off-multiple-sessions" && \
            subject.isInGroup("wheel")) { return polkit.Result.YES; }
        );
    '';

    systemd.user.services.polkit-gnome-authentication-agent-1 = {
        wantedBy = [ "default.target" ];
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
        };
    };

};}
