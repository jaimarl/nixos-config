{
    security.polkit.extraConfig = ''
        if (( action.id == "org.freedesktop.login1.reboot" || \
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" || \
            action.id == "org.freedesktop.login1.power-off" || \
            action.id == "org.freedesktop.login1.power-off-multiple-sessions" && \
            subject.isInGroup("wheel")) { return polkit.Result.YES; });
    '';
}
