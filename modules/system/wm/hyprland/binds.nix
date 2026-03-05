{ config, osConfig, lib, ... }: let
    option = osConfig.modules.system.wm.hyprland;
in {

#--- [ Config ] -----------------------------------------------------
config = {

    wayland.windowManager.hyprland.settings.bind = let
        terminal = config.global.home.terminal;
        zshRun = cmd: "zsh -ic '${cmd}; exec zsh'";
    in [
        # Programs
        "Super, Return, exec, ${terminal}"
        "Super, E, exec, ${terminal} ${zshRun "y"}"
        "Super, Grave, exec, ${terminal} nvim"
        "Super, B, exec, firefox"

        # Screen
        "Super, Equal, exec, pypr zoom ++1"
        "Super, Minus, exec, pypr zoom --1"
        "Super, 0, exec, pypr zoom 1.0"

        # Windows Management
        "Super, Q, killactive"
        "Super, P, pin"
        ", F11, fullscreen"

        "Super, left, movefocus, l"
        "Super, right, movefocus, r"
        "Super, up, movefocus, u"
        "Super, down, movefocus, d"

        "Super Shift, left, movewindow, l"
        "Super Shift, right, movewindow, r"
        "Super Shift, up, movewindow, u"
        "Super Shift, down, movewindow, d"

        # Workspaces
        "Super, 1, workspace, 1"
        "Super, 2, workspace, 2"
        "Super, 3, workspace, 3"
        "Super, 4, workspace, 4"
        "Super, 5, workspace, 5"
        "Super, 6, workspace, 6"
        "Super, 7, workspace, 7"
        "Super, 8, workspace, 8"
        "Super, 9, workspace, 9"

        "Super Shift, 1, movetoworkspacesilent, 1"
        "Super Shift, 2, movetoworkspacesilent, 2"
        "Super Shift, 3, movetoworkspacesilent, 3"
        "Super Shift, 4, movetoworkspacesilent, 4"
        "Super Shift, 5, movetoworkspacesilent, 5"
        "Super Shift, 6, movetoworkspacesilent, 6"
        "Super Shift, 7, movetoworkspacesilent, 7"
        "Super Shift, 8, movetoworkspacesilent, 8"
        "Super Shift, 9, movetoworkspacesilent, 9"
    ];

    wayland.windowManager.hyprland.settings.bindm = [

    ];

};}
