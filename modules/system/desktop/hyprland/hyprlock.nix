{ config, osConfig, lib, pkgs, ... }: let
    option = osConfig.modules.system.desktop.hyprland;

    colors = config.lib.stylix.colors;
    fonts = config.stylix.fonts;

    monitor = lib.head (lib.splitString "," (lib.head option.monitors));

    c = lib.mapAttrs (name: value: "rgb(${value})") colors;
    spotify = pkgs.writeShellScript "spotify-now-playing" ''
        echo $(${pkgs.playerctl}/bin/playerctl metadata -p spotify --format "{{artist}} — {{title}}")
    '';
in {

#--- [ Config ] -----------------------------------------------------
config = { 
    
    programs.hyprlock = {
        enable = true;
        settings = {
            general = {
                hide_cursor = true;
                ignore_empty_input = true;
                fail_timeout = 0;
            };

            background = [{ # Background
                path = "~/.cache/wallpaper/current.png";
                blur_size = 4;
                blur_passes = 3;
                brightness = 0.6;
                contrast = 1.5;
            }];

            label = [
                { # Hours
                    monitor = monitor;
                    font_family = "${pkgs.inter}/share/fonts/truetype/Inter.ttc Black";
                    text = "cmd[update:1000] echo \"$(date +\"%H\")\"";
                    font_size = 125;
                    position = "0, 230";
                    color = c.base05;
                }
                { # Minutes
                    monitor = monitor;
                    font_family = "${pkgs.inter}/share/fonts/truetype/Inter.ttc Black";
                    text = "cmd[update:1000] echo \"$(date +\"%M\")\"";
                    font_size = 125;
                    position = "0, 100";
                    color = c.base0D;
                }
                { # Date
                    monitor = monitor;
                    font_family = "${fonts.sansSerif.name} Bold";
                    text = "cmd[update:1000] echo -e \"$(date +\"%A, %d %B\")\"";
                    font_size = 15;
                    color = c.base05;
                }
                { # Spotify
                    monitor = monitor;
                    font_family = "${fonts.sansSerif.name}";
                    text = "cmd[update:1000] ${spotify}";
                    font_size = 14;
                    position = "0, 30";
                    valign = "bottom";
                    color = c.base05;
                }
            ] ++ lib.optionals (osConfig.host.system.hasBattery) [
                { # Battery
                    monitor = monitor;
                    font_family = "${fonts.sansSerif.name}";
                    text = "cmd[update:5000] echo \"$(status=$(cat /sys/class/power_supply/BAT0/status); cap=$(cat /sys/class/power_supply/BAT0/capacity); icons=('󰂎' '󰁺' '󰁻' '󰁼' '󰁽' '󰁾' '󰁿' '󰂀' '󰂁' '󰂂' '󰁹'); idx=$((cap / 9)); [ $idx -gt 10 ] && idx=10; if [ \"$status\" = 'Charging' ]; then icon='󰂄'; else icon=\${icons[$idx]}; fi; echo \"$cap%   $icon\")\"";
                    font_size = 14;
                    position = "-15, -15";
                    halign = "right";
                    valign = "top";
                    color = c.base05;
                }
            ];

            input-field = [{ # Password
                monitor = monitor;
                font_family = "${fonts.sansSerif.name}";
                placeholder_text = "<span foreground=\"##${colors.base04}\">Пароль</span>";
                size = "250, 50";
                position = "0, -264";
                rounding = 15;
                dots_spacing = 0.25;
                outline_thickness = 0;
                fade_on_empty = false;
                inner_color = c.base01;
                check_color = c.base01;
                font_color = c.base0D;
            }];
        };
    };

};}
