{ config, osConfig, lib, pkgs, ... }: let
    option = osConfig.modules.system.desktop.hyprland;

    colors = config.lib.stylix.colors.withHashtag;
    fonts = config.stylix.fonts;
    opacity = if ! option.opacity.enable || ! option.waybar.opacity then 1 else option.opacity.value;

    record = pkgs.writeShellScript "record" ''
        if [ -z $(pgrep wf-recorder) ]; then
            echo "{\"text\": \"󰻂\", \"class\": \"stopped\"}"
        else
            echo "{\"text\": \"󰻂\", \"class\": \"running\"}"
        fi
    '';
in {

#--- [ Config ] -----------------------------------------------------
config = {

    wayland.windowManager.hyprland.settings.exec-once = [
        "waybar"
    ];

    programs.waybar = {
        enable = true;

        settings.mainBar = {
            layer = "top";
            position = option.waybar.position;

            margin-left = if option.waybar.float then 5 else 0;
            margin-right = if option.waybar.float then 5 else 0; 
            margin-top = if option.waybar.float
                && option.waybar.position == "top" then 5 else 0;
            margin-bottom = if option.waybar.float
                && option.waybar.position == "bottom" then 5 else 0;

            width = if option.waybar.width > 0 then option.waybar.width else null;
            height = 36;

            modules-left = [
                "custom/nix"
                "hyprland/workspaces"
                "mpris#play" "mpris#prev" "mpris#next" "mpris#text"
            ];
            modules-center = [
                "custom/cal-icon" "clock#cal-text"
                "custom/clock-icon" "clock#text"
            ] ++ lib.optionals (option.hypridle.enable) [
                "idle_inhibitor"
            ] ++ [
                "custom/record"
            ];
            modules-right = [
                "network#icon" "network#text"
                "custom/language-icon" "hyprland/language#text"
                "backlight#icon" "backlight#text"
                "pulseaudio#mic" "pulseaudio#icon" "pulseaudio#text"
            ] ++ lib.optionals (osConfig.host.system.hasBattery) [
                "battery#icon" "battery#text"
            ] ++ [
                "custom/power"
            ];


            # Left Modules
            "custom/nix" = {
                format = "󱄅";
                interval = "once";
                tooltip = false;
            };

            "hyprland/workspaces" = {
                format = "{icon}";
                format-icons = {
                    "1" = "1"; "10" = "1"; "19" = "1";
                    "2" = "2"; "11" = "2"; "20" = "2";
                    "3" = "3"; "12" = "3"; "21" = "3";
                    "4" = "4"; "13" = "4"; "22" = "4";
                    "5" = "5"; "14" = "5"; "23" = "5";
                    "6" = "6"; "15" = "6"; "24" = "6";
                    "7" = "7"; "16" = "7"; "25" = "7";
                    "8" = "8"; "17" = "8"; "26" = "8";
                    "9" = "9"; "18" = "9"; "27" = "9";
                };
            };

            "mpris#play" = {
                format = "󰏤";
                format-paused = "󰐊";
                on-click = "playerctl -p spotify play-pause";
                on-click-right = "";
                on-click-middle = "";
                player = "spotify";
                tooltip = false;
            };
            "mpris#prev" = {
                format = "󰒮";
                on-click = "playerctl -p spotify previous";
                on-click-right = "";
                on-click-middle = "";
                player = "spotify";
                tooltip = false;
            };
            "mpris#next" = {
                format = "󰒭";
                on-click = "playerctl -p spotify next";
                on-click-right = "";
                on-click-middle = "";
                player = "spotify";
                tooltip = false;
            };
            "mpris#text" = {
                format = "Spotify";
                on-click = "";
                on-click-right = "";
                on-click-middle = "";
                player = "spotify";
                tooltip = false;
            };


            # Center Modules
            "custom/cal-icon" = {
                format = "󰃭";
                interval = "once";
                tooltip = false;
            };
            "clock#cal-text" = {
                format = "{:L%A,  %d %B}";
                tooltip = false;
            };

            "custom/clock-icon" = {
                format = "󰥔";
                interval = "once";
                tooltip = false;
            };
            "clock#text" = {
                tooltip = false;
            };

            "idle_inhibitor" = {
                format = "{icon}";
                format-icons = {
                    activated = "󰅶";
                    deactivated = "󰾪";
                };
                tooltip = false;
            };

            "custom/record" = {
                format = "{}";
                exec = "${record}";
                exec-on-event = false;
                return-type = "json";
                interval = 1;
                signal = 2;
                tooltip = false;
            };


            # Right Modules
            "network#icon" = {
                format-wifi = "{icon}";
                format-ethernet = "󰈀";
                format-disconnected = "󰌺";
                format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
                interval = 10;
                tooltip = false;
            };
            "network#text" = {
                format-wifi = "{essid}";
                format-ethernet = "Ethernet";
                format-disconnected = "Отключено";
                tooltip = false;
            };

            "custom/language-icon" = {
                format = "󰇧";
                interval = "once";
                tooltip = false;
            };
            "hyprland/language#text" = {
                format-en = "EN";
                format-ru = "RU";
            };

            "backlight#icon" = {
                format = "{icon}";
                format-icons = [ "󰄰" "󰪞" "󰪟" "󰪠" "󰪡" "󰪢" "󰪣" "󰪤" "󰪥" ];
                on-scroll-up = "";
                on-scroll-down = "";
                tooltip = false;
            };
            "backlight#text" = {
                format = "{percent}%";
                on-scroll-up = "";
                on-scroll-down = "";
                align = 1;
                tooltip = false;
            };

            "pulseaudio#mic" = {
                format = "{format_source}";
                format-source = "󰍬";
                format-source-muted = "󰍭";
                on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
                on-scroll-up = "";
                on-scroll-down = "";
                tooltip = false;
            };
            "pulseaudio#icon" = {
                format = "󰕾";
                format-muted = "󰖁";
                on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
                on-scroll-up = "";
                on-scroll-down = "";
                align = 0;
                tooltip = false;
            };
            "pulseaudio#text" = {
                format = "{volume}%";
                on-scroll-up = "";
                on-scroll-down = "";
                align = 1;
                tooltip = false;
            };

            "battery#icon" = {
                format = "{icon}";
                format-charging = "󰂄";
                format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
                states = {
                    warning = 15;
                    critical = 5;
                };
                interval = 1;
                tooltip = false;
            };
            "battery#text" = {
                format = "{capacity}%";
                align = 1;
                interval = 1;
                tooltip = false;
            };

            "custom/power" = {
                format = "󰐥";
                interval = "once";
                tooltip = false;
            };
        };

        style = ''
            @define-color base00 alpha(${colors.base00}, ${toString opacity});
            @define-color base01 ${colors.base01};
            @define-color base02 ${colors.base02};
            @define-color base03 ${colors.base03};
            @define-color base04 ${colors.base04};
            @define-color base05 ${colors.base05};
            @define-color base06 ${colors.base06};
            @define-color base07 ${colors.base07};
            @define-color base08 ${colors.base08};
            @define-color base09 ${colors.base09};
            @define-color base0A ${colors.base0A};
            @define-color base0B ${colors.base0B};
            @define-color base0C ${colors.base0C};
            @define-color base0D ${colors.base0D};
            @define-color base0E ${colors.base0E};
            @define-color base0F ${colors.base0F};

            * {
                font-family: "${fonts.sansSerif.name}", "JetBrainsMono Nerd Font Propo";
                font-size: ${toString fonts.sizes.desktop}pt;
            }

            window#waybar {
                
                border-top-left-radius: ${toString (
                    if option.waybar.float then 5
                        else if option.waybar.width > 0 && option.waybar.position == "bottom"
                            then 5
                        else 0
                )}px;
                border-top-right-radius: ${toString (
                    if option.waybar.float then 5
                        else if option.waybar.width > 0 && option.waybar.position == "bottom"
                            then 5
                        else 0
                )}px;
                border-bottom-left-radius: ${toString (
                    if option.waybar.float then 5
                        else if option.waybar.width > 0 && option.waybar.position == "top"
                            then 5
                        else 0
                )}px;
                border-bottom-right-radius: ${toString (
                    if option.waybar.float then 5
                        else if option.waybar.width > 0 && option.waybar.position == "top"
                            then 5
                        else 0
                )}px;

                background: @base00;
            }
            
            ${builtins.readFile ./style.css}

             #custom-record {
                margin-left: ${toString (if option.hypridle.enable then 0 else 4)}px;
                padding-left: ${toString (if option.hypridle.enable then 5 else 10)}px;
                border-top-left-radius: ${toString (if option.hypridle.enable then 0 else 5)}px;
                border-bottom-left-radius: ${toString (if option.hypridle.enable then 0 else 5)}px;
            }

            #pulseaudio.text {
                border-top-right-radius: ${toString (if osConfig.host.system.hasBattery then 0 else 5)};
                border-bottom-right-radius: ${toString (if osConfig.host.system.hasBattery then 0 else 5)};
            }
        '';
    };

};}
