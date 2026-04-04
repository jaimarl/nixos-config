{ config, osConfig, lib, pkgs, ... }: let
    option = osConfig.modules.system.desktop.hyprland;

    screenshot = pkgs.writeShellApplication {
        name = "screenshot";
        runtimeInputs = with pkgs; [
            procps coreutils
            slurp
            wl-clipboard
            hyprshot
            libnotify
        ];
        text = ''
            SAVE_DIR="${config.host.home.paths.screenshots}"
            FILE_NAME="$(date +'%Y-%m-%d-%H%M%S')_hyprshot.png"
            FILE_PATH="$SAVE_DIR/$FILE_NAME"

            mkdir -p "$SAVE_DIR"

            notify () {
                until [ -f "$FILE_PATH" ]
                do
                    sleep 0.1
                done

                notify-send -i "$FILE_PATH" -u low "Screenshot saved" "Image saved in $FILE_PATH and copied to the clipboard."
            }

            case "$1" in
                region)
                    hyprshot -m region -o "$SAVE_DIR" -f "$FILE_NAME" -zs & notify
                    ;;
                output)
                    hyprshot -m active -m output -o "$SAVE_DIR" -f "$FILE_NAME" -s & notify
                    ;;
                *)
                    exit 1
                    ;;
            esac

        '';
    };
    
    record = pkgs.writeShellApplication {
        name = "record";
        runtimeInputs = with pkgs; [
            procps coreutils
            slurp
            jq
            wl-clipboard
            wf-recorder
            ffmpegthumbnailer
            libnotify
        ];
        text = ''
            STATE_FILE="/tmp/wf-recorder-current-file.txt"
            THUMB_FILE="''${XDG_RUNTIME_DIR:-/tmp}/video_thumb.png"
            SAVE_DIR="${config.host.home.paths.records}"
            FILENAME="$(date +'%Y-%m-%d-%H%M%S')_wf_recorder.mp4"
            FULL_PATH="$SAVE_DIR/$FILENAME"

            WF_ARGS=("-f" "$FULL_PATH" "-c" "${option.record.codec}")

            mkdir -p "$SAVE_DIR"

            if [[ "$1" == "stop" && -n $(pgrep wf-recorder) ]]; then
                pkill -INT -x wf-recorder

                if [ -f "$STATE_FILE" ]; then
                    RECORDED_FILE=$(cat "$STATE_FILE")

                    until [ -f "$RECORDED_FILE" ]
                    do
                        sleep 0.1
                    done
                    
                    wl-copy -t text/uri-list "file://$RECORDED_FILE"
                    
                    ffmpegthumbnailer -i "$RECORDED_FILE" -o "$THUMB_FILE" -s 128
                    notify-send -i "$THUMB_FILE" -u low "Recording saved" "Video saved in $RECORDED_FILE and copied to the clipboard."
                    
                    rm "$STATE_FILE"
                fi
                
                pkill -RTMIN+2 waybar
                exit 0
            fi

            case "$1" in
                monitor)
                    MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
                    WF_ARGS+=("-o" "$MONITOR")                    
                    ;;
                area)
                    GEOMETRY=$(slurp)
                    if [ -z "$GEOMETRY" ]; then
                        exit 1
                    fi
                    WF_ARGS+=("-g" "$GEOMETRY")
                    ;;
                *)
                    exit 1
                    ;;
            esac

            echo "$FULL_PATH" > "$STATE_FILE"

            pkill -RTMIN+2 waybar

            wf-recorder "''${WF_ARGS[@]}" &
            disown
        '';
    };

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

    special = pkgs.writeShellApplication {
        name = "close";
        runtimeInputs = with pkgs; [
            jq
        ];
        text = ''
            active=$(hyprctl -j monitors | jq --raw-output '.[] | select(.focused==true).specialWorkspace.name | split(":") | if length > 1 then .[1] else "" end')

            if [[ ''${#active} -gt 0 ]]; then
                hyprctl dispatch togglespecialworkspace "$active"
            fi
        '';
    };
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
            "Super Shift, B, exec, firefox --private-window"
            "Super, C, exec, spotify"

            # Screen
            "Super Shift, S, exec, ${screenshot}/bin/screenshot region"
            "Super Control, S, exec, ${screenshot}/bin/screenshot output"

            "Super Shift, R, exec, ${record}/bin/record area"
            "Super Control, R, exec, ${record}/bin/record monitor"
            "Super, R, exec, ${record}/bin/record stop"

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

            "Super Shift, left, movewindow, l"
            "Super Shift, right, movewindow, r"
            "Super Shift, up, movewindow, u"
            "Super Shift, down, movewindow, d"

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

            # Special Workspaces
            "Super, Escape, exec, ${special}/bin/close"
            "Super, X, togglespecialworkspace, scratch"
            "Super Shift, X, movetoworkspacesilent, scratch"
        ];

        bindm = [
            "Super, mouse:272, movewindow"
            "Super, mouse:273, resizewindow"
        ];
    };

};}
