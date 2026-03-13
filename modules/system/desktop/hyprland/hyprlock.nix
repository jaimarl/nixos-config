{ config, osConfig, lib, pkgs, ... }: let
    option = osConfig.modules.system.desktop.hyprland;

    colors = config.lib.stylix.colors;
    fonts = config.stylix.fonts;

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
                contrast = 1.75;
            }];

            shape = [
                { # Main Panel
                    size = "500, 500";
                    rounding = 20;
                    color = c.base00;
                }
                { # User Panel
                    size = "320, 55";
                    position = "0, -51";
                    rounding = 20;
                    color = c.base01;
                }
            ];

            label = [
                { # Time
                    font_family = "${fonts.sansSerif.name} Bold";
                    text = "cmd[update:1000] echo \"$(date +\"%H:%M\")\"";
                    font_size = 60;
                    position = "0, 119";
                    color = c.base0D;
                }
                { # Date
                    font_family = "${fonts.sansSerif.name} Semibold";
                    text = "cmd[update:1000] echo -e \"$(date +\"%A, %d %B\")\"";
                    font_size = 19;
                    position = "0, 49";
                    color = c.base05;
                }
                { # Username
                    font_family = "${fonts.sansSerif.name} Semibold";
                    text = "$USER";
                    font_size = 16;
                    position = "0, -51";
                    color = c.base05;
                }
                { # Spotify
                    font_family = "${fonts.sansSerif.name}";
                    text = "cmd[update:1000] ${spotify}";
                    font_size = 11;
                    position = "0, -195";
                    color = c.base04;
                }
            ] ++ lib.optionals (osConfig.host.system.hasBattery) [
                { # Battery
                    font_family = "${fonts.sansSerif.name} Semibold";
                    text = "cmd[update:5000] echo \"$(status=$(cat /sys/class/power_supply/BAT0/status); cap=$(cat /sys/class/power_supply/BAT0/capacity); icons=('󰂎' '󰁺' '󰁻' '󰁼' '󰁽' '󰁾' '󰁿' '󰂀' '󰂁' '󰂂' '󰁹'); idx=$((cap / 9)); [ $idx -gt 10 ] && idx=10; if [ \"$status\" = 'Charging' ]; then icon='󰂄'; else icon=\${icons[$idx]}; fi; echo \"$cap%   $icon\")\"";
                    font_size = 14;
                    position = "-30, 30";
                    halign = "right";
                    valign = "bottom";
                    color = c.base05;
                }
            ];

            input-field = [{ # Password
                font_family = "${fonts.sansSerif.name}";
                placeholder_text = "<span foreground=\"##${colors.base04}\">Пароль</span>";
                size = "320, 55";
                position = "0, -121";
                rounding = 20;
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
