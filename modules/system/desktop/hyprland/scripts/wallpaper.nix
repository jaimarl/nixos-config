{ config, osConfig, lib, pkgs, ... }: let
    option = osConfig.modules.system.desktop.hyprland;

    wallScript = pkgs.writeShellApplication {
        name = "wp";
        runtimeInputs = with pkgs; [
            coreutils findutils
            awww
            fzf
            chafa
        ];
        text = ''
            CACHE="$HOME/.cache/wallpaper"
            WALL_DIR="${config.host.home.paths.wallpapers}"
            MODE=''${1:-"select"}

            case "$MODE" in
                set)
                    if [ -n "$2" ]; then
                        WALLPAPER="$2"
                    else
                        exit 1
                    fi
                    ;;
                random)
                    CURRENT_WALL=""
                    if [ -L "$CACHE/current.png" ]; then
                        CURRENT_WALL=$(readlink "$CACHE/current.png")
                    fi

                    ALL_WALLS=$(find "$WALL_DIR" -type f | grep -E "\.(jpg|jpeg|png|webp|gif)$")
                    
                    if [ -n "$CURRENT_WALL" ]; then
                        RANDOM_WALL=$(echo "$ALL_WALLS" | grep -vF "$CURRENT_WALL" | shuf -n 1)
                    else
                        RANDOM_WALL=$(echo "$ALL_WALLS" | shuf -n 1)
                    fi

                    if [ -n "$RANDOM_WALL" ]; then
                        WALLPAPER="$RANDOM_WALL"
                    else
                        exit 1
                    fi
                    ;;
                select)
                    WALLPAPER=$(find "$WALL_DIR" -type f \
                        | grep -E "\.(jpg|jpeg|png|webp|gif)$" \
                        | fzf --prompt="Select wallpaper: " \
                            --delimiter="/" \
                            --with-nth=-1 \
                            --preview "chafa -s \''${FZF_PREVIEW_COLUMNS}x\''${FZF_PREVIEW_LINES} {}" \
                            --preview-window=right:60% \
                            --layout=reverse) 

                    if [ -z "$WALLPAPER" ]; then
                        exit 0
                    fi
                    ;;
                *)
                    exit 1
                    ;;
            esac

            if [[ -z $(pgrep awww-daemon) ]]; then
                awww-daemon --no-cache &
            fi

            ABS_PATH=$(realpath "$WALLPAPER")

            mkdir -p "$CACHE"
            ln -sf "$ABS_PATH" "$CACHE/current.png"
            awww img "$ABS_PATH" \
                --transition-type grow \
                --transition-pos 0.5,${toString (if option.waybar.position == "top" then 0.99 else 0)} \
                --transition-step 90 \
                --transition-duration 1 \
                --transition-fps 144
        '';
    };
in { home.packages = with pkgs; [ wallScript ]; }
