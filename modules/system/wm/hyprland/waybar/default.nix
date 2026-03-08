{ config, osConfig, lib, ... }: let
    option = osConfig.modules.system.wm.hyprland;
    colors = config.lib.stylix.colors.withHashtag;
    fonts = config.stylix.fonts;
    opacity = if ! option.opacity.enable || ! option.waybar.opacity then 1 else option.opacity.value;
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

            width = if option.waybar.width != 1 then option.waybar.width else null;

            modules-left = [
                "custom/nix"
                "hyprland/workspaces"
            ];
            modules-center = [
                "clock#cal-icon" "clock#cal-text"
                "clock#icon" "clock#text"
            ];
            modules-right = [
                "network#icon" "network#text"
                "hyprland/language#icon" "hyprland/language#text"
                "backlight#icon" "backlight#text"
                "pulseaudio#mic" "pulseaudio#icon" "pulseaudio#text"
                "battery#icon" "battery#text"
                "custom/power"
            ];


            # Left Modules
            "custom/nix" = {
                format = "󱄅";
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


            # Center Modules
            "clock#cal-icon" = {
                format = "󰃭";
                tooltip = false;
            };
            "clock#cal-text" = {
                format = "{:L%A,  %d %B}";
                tooltip = false;
            };
            "clock#icon" = {
                format = "󰥔";
                tooltip = false;
            };
            "clock#text" = {
                tooltip = false;
            };


            # Right Modules
            "network#icon" = {
                format-wifi = "󰖩";
                format-ethernet = "󰈀";
                format-disconnected = "󰌺";
                tooltip = false;
            };
            "network#text" = {
                format-wifi = "{essid}";
                format-ethernet = "Ethernet";
                format-disconnected = "Отключено";
                tooltip = false;
            };

            "hyprland/language#icon" = {
                format = "󰌌";
            };
            "hyprland/language#text" = {
                format-en = "EN";
                format-ru = "RU";
            };

            "backlight#icon" = {
                format = "{icon}";
                format-icons = [ "󰄰" "󰪞" "󰪟" "󰪠" "󰪡" "󰪢" "󰪣" "󰪤" "󰪥" ];
                tooltip = false;
            };
            "backlight#text" = {
                format = "{percent}%";
                align = 1;
                tooltip = false;
            };

            "pulseaudio#mic" = {
                format = "{format_source}";
                format-source = "󰍬";
                format-source-muted = "󰍭";
                tooltip = false;
            };
            "pulseaudio#icon" = {
                format = "󰕾";
                format-muted = "󰖁";
                align = 0;
                tooltip = false;
            };
            "pulseaudio#text" = {
                format = "{volume}%";
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
                interval = 1;
                align = 1;
                tooltip = false;
            };

            "custom/power" = {
                format = "󰐥";
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
                border-radius: ${toString (if option.waybar.float then 5 else 0)}px;
                background: @base00;
            }

            ${builtins.readFile ./style.css}
        '';
    };

};}
