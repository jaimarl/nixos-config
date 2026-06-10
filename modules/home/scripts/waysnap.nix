{ config, lib, pkgs, ... }: let
    option = config.modules.home.scripts.waysnap;
    colors = config.lib.stylix.colors.withHashtag;

    script = pkgs.writeShellApplication {
        name = "waysnap";
        runtimeInputs = with pkgs; [ wl-clipboard wayfreeze slurp grim satty jq ];
        text = ''
            FILENAME="${config.host.home.paths.screenshots}/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
            SLURP_FLAGS=(-c "${colors.base0D}" -b "${colors.base00}d9")
            
            EDIT_IN_SATTY=0
            MODE=""

            for arg in "$@"; do
                case "$arg" in
                    -h|--help) 
                        echo "Usage: waysnap [region|output] [-e|--edit]"
                        exit 0 
                        ;;
                    region|output) MODE="$arg" ;;
                    -e|--edit) EDIT_IN_SATTY=1 ;;
                    *) 
                        echo "Error: Unknown argument '$arg'" >&2
                        exit 1 
                        ;;
                esac
            done

            [ -z "$MODE" ] && { echo "Error: No mode specified" >&2; exit 1; }

            if [ "$MODE" = "region" ]; then
                wayfreeze & FREEZE_PID=$!
                sleep 0.1
                
                TMP_GEOM=$(mktemp)
                slurp "''${SLURP_FLAGS[@]}" 2>/dev/null > "$TMP_GEOM" & SLURP_PID=$!
                
                wait -n "$FREEZE_PID" "$SLURP_PID" 2>/dev/null || true
                
                GEOM=$(cat "$TMP_GEOM" 2>/dev/null)
                rm -f "$TMP_GEOM"

                if ! kill -0 "$FREEZE_PID" 2>/dev/null; then
                    kill "$SLURP_PID" 2>/dev/null || true
                    exit 1
                fi
                
                if [ -n "$GEOM" ]; then
                    grim -g "$GEOM" "$FILENAME" 2>/dev/null || true
                fi
                
                kill "$FREEZE_PID" 2>/dev/null || true
                
                [ ! -s "$FILENAME" ] && exit 1
            else
                MONITOR=""

                case "''${XDG_CURRENT_DESKTOP,,}" in
                    niri)     MONITOR=$(niri msg -j focused-output 2>/dev/null | jq -r .name) ;;
                esac

                if [ -n "$MONITOR" ]; then
                    grim -o "$MONITOR" "$FILENAME" || exit 1
                else
                    slurp -o "''${SLURP_FLAGS[@]}" 2>/dev/null | grim -g - "$FILENAME" 2>/dev/null || exit 1
                fi
            fi

            wl-copy -t image/png < "$FILENAME"
            echo "Screenshot saved to: $FILENAME"

            if [ "$EDIT_IN_SATTY" -eq 1 ]; then
                satty --filename "$FILENAME" \
                --output-filename "''${FILENAME%.png}_edited.png" \
                --early-exit --early-exit-save-as \
                --disable-notifications
            fi;
        '';
    };
in {

#--- [ Options ] ----------------------------------------------------
options.modules.home.scripts.waysnap = {
    enable = lib.mkOption { type = lib.types.bool; default = false; };
};

config = lib.mkIf option.enable { home.packages = [ script ]; };}
