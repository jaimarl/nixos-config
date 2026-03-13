{ config, osConfig, lib, pkgs, ... }: let
    option = osConfig.modules.system.desktop.hyprland;

    recorderScript = pkgs.writeShellApplication {
        name = "record";
        runtimeInputs = with pkgs; [
            procps coreutils
            slurp
            jq
            wl-clipboard
            wf-recorder
        ];
        text = ''
            STATE_FILE="/tmp/wf-recorder-current-file.txt"
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
in { home.packages = with pkgs; [ recorderScript ]; }
