{ config, osConfig, lib, pkgs, ... }: let
    option = osConfig.modules.system.desktop.hyprland;

    toggleFloat = pkgs.writeShellScript "toggle-float" ''
        is_floating=$(hyprctl activewindow | awk -F": " '/floating:/ {print $2}')

        if [[ $is_floating == "1" ]]; then
            hyprctl dispatch togglefloating
        else
            hyprctl dispatch togglefloating
            hyprctl dispatch resizeactive exact 66% 66%
            hyprctl dispatch centerwindow
        fi
    '';
in {

#--- [ Config ] -----------------------------------------------------
config = {

    wayland.windowManager.hyprland.settings = {
        bind = let
            terminal = config.global.home.terminal;
            zshRun = cmd: "zsh -ic '${cmd}; exec zsh'";
        in [
            # Programs
            "Super, Return, exec, kitty"
            "Super, E, exec, kitty zsh -ic 'y; exec zsh'"
            "Super, Grave, exec, kitty nvim"
            "Super, B, exec, firefox"

            # Screen
            "Super Shift, S, exec, ${pkgs.hyprshot}/bin/hyprshot -zm region -o ${config.host.home.paths.screenshots}"
            "Super Control, S, exec, ${pkgs.hyprshot}/bin/hyprshot -m active -m output -o ${config.host.home.paths.screenshots}"

            "Super Shift, R, exec, record area"
            "Super Control, R, exec, record monitor"
            "Super, R, exec, record stop"

            "Super Shift, P, exec, ${pkgs.hyprpicker}/bin/hyprpicker -a"

            "Super, Equal, exec, ${pkgs.pyprland}/bin/pypr zoom ++1"
            "Super, Minus, exec, ${pkgs.pyprland}/bin/pypr zoom --1"
            "Super, 0, exec, ${pkgs.pyprland}/bin/pypr zoom 1.0"

            "Super, L, exec, hyprlock"

            # Windows Management
            "Super, Q, killactive"
            "Super, W, exec, ${toggleFloat}"
            "Super, P, pin"
            ", F11, fullscreen"

            "Super, left, movefocus, l"
            "Super, right, movefocus, r"
            "Super, up, movefocus, u"
            "Super, down, movefocus, d"

            "Super Shift, left, swapwindow, l"
            "Super Shift, right, swapwindow, r"
            "Super Shift, up, swapwindow, u"
            "Super Shift, down, swapwindow, d"

            # Workspaces
            "Super, 1, split:workspace, 1"
            "Super, 2, split:workspace, 2"
            "Super, 3, split:workspace, 3"
            "Super, 4, split:workspace, 4"
            "Super, 5, split:workspace, 5"
            "Super, 6, split:workspace, 6"
            "Super, 7, split:workspace, 7"
            "Super, 8, split:workspace, 8"
            "Super, 9, split:workspace, 9"

            "Super Shift, 1, split:movetoworkspacesilent, 1"
            "Super Shift, 2, split:movetoworkspacesilent, 2"
            "Super Shift, 3, split:movetoworkspacesilent, 3"
            "Super Shift, 4, split:movetoworkspacesilent, 4"
            "Super Shift, 5, split:movetoworkspacesilent, 5"
            "Super Shift, 6, split:movetoworkspacesilent, 6"
            "Super Shift, 7, split:movetoworkspacesilent, 7"
            "Super Shift, 8, split:movetoworkspacesilent, 8"
            "Super Shift, 9, split:movetoworkspacesilent, 9"
        ];

        bindm = [
            "Super, mouse:272, movewindow"
            "Super, mouse:273, resizewindow"
        ];
    };

};}
