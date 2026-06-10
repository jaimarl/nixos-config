{ config, lib, pkgs, ... }: let
    option = config.modules.home.desktop.niri;

    toggleFloating = pkgs.writeShellScript "start" ''
        WINDOW_DATA=$(niri msg --json focused-window 2>/dev/null)

        if [ -z "$WINDOW_DATA" ] || [ "$WINDOW_DATA" == "null" ]; then
            exit 0
        fi

        IS_FLOATING=$(echo "$WINDOW_DATA" | ${pkgs.jq}/bin/jq -r '.is_floating')

        if [ "$IS_FLOATING" == "true" ]; then
            niri msg action toggle-window-floating
            niri msg action set-column-width 50%
        else
            niri msg action toggle-window-floating
            niri msg action set-window-width 50%
            niri msg action set-window-height 66%
            niri msg action center-column
        fi
    '';
in {

#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    modules.home.desktop.niri.configLines = ''
        binds {
            Mod+Shift+P repeat=false { spawn-sh "${pkgs.hyprpicker}/bin/hyprpicker -a -u 150"; }

            Mod+Q repeat=false { close-window; }
            Mod+W repeat=false { spawn "${toggleFloating}"; }
            Mod+Shift+W repeat=false { switch-focus-between-floating-and-tiling; }
            Mod+F repeat=false { maximize-column; }
            F11 repeat=false { fullscreen-window; } 
            Mod+R { switch-preset-column-width; }
            Mod+Shift+R { switch-preset-column-width-back; }
            Mod+Comma { set-column-width "-5%"; }
            Mod+Period { set-column-width "+5%"; }
            Mod+O repeat=false { toggle-overview; }

            Mod+Left { focus-column-left; }
            Mod+Right { focus-column-right; }
            Mod+Up { focus-window-up; }
            Mod+Down { focus-window-down; }
            Mod+Shift+Left { move-column-left; }
            Mod+Shift+Right { move-column-right; }
            Mod+Shift+Up { move-window-up; }
            Mod+Shift+Down { move-window-down; }

            Mod+Home { focus-column-first; }
            Mod+End { focus-column-last; }
            Mod+Shift+Home { move-column-to-first; }
            Mod+Shift+End { move-column-to-last; }

            Mod+Ctrl+Left { focus-monitor-left; }
            Mod+Ctrl+Right { focus-monitor-right; }
            Mod+Ctrl+Up { focus-monitor-up; }
            Mod+Ctrl+Down { focus-monitor-down; }
            Mod+Shift+Ctrl+Left { move-column-to-monitor-left; }
            Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
            Mod+Shift+Ctrl+Up { move-column-to-monitor-up; }
            Mod+Shift+Ctrl+Down { move-column-to-monitor-down; }

            Mod+Page_Up { focus-workspace-up; }
            Mod+Page_Down { focus-workspace-down; }
            Mod+Shift+Page_Up { move-column-to-workspace-up focus=false; }
            Mod+Shift+Page_Down { move-column-to-workspace-down focus=false; }

            ${builtins.concatStringsSep "\n" (map (x: ''
                "Mod+${x}" { focus-workspace ${x}; }
                "Mod+Shift+${x}" repeat=false { move-window-to-workspace ${x} focus=false; }
            '') (map toString (pkgs.lib.range 1 9)))}

            Mod+BracketLeft  { consume-or-expel-window-left; }
            Mod+BracketRight { consume-or-expel-window-right; }
        }
    '';

};}
