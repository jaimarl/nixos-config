{ lib, ... }: {

    imports = [
        ./packages.nix
        ./desktop-entries.nix
    ];

    #--- Host Options ---------------------------
    host.home = {

    };


    #--- Modules --------------------------------
    core.stylix = {

    };

    modules.home = {
        scripts = {
            waysnap.enable = true;
        };
        kitty.enable = true;
        zenBrowser.enable = true;
        spotify.enable = true;
        desktop = {
            niri = {
                enable = true;
                lockscreen.output = "eDP-1";
                userConfig = ''
                    output "eDP-1" {
                        mode "1920x1080@60"
                        scale 1
                        hot-corners {
                            off
                        }
                    }

                    binds {
                        Mod+Return repeat=false { spawn "kitty"; }
                        Mod+E repeat=false { spawn-sh "kitty zsh -ic 'y; exec zsh'"; }
                        Mod+Grave repeat=false { spawn-sh "kitty nvim"; }
                        Mod+B repeat=false { spawn-sh "zen-twilight"; }
                        Mod+Shift+B repeat=false { spawn-sh "zen-twilight --private-window"; }

                        Mod+Shift+S repeat=false { spawn-sh "waysnap region"; }
                        Mod+Shift+Alt+S repeat=false { spawn-sh "waysnap region -e"; }
                        Mod+Ctrl+S repeat=false { spawn-sh "waysnap output"; }
                        Mod+Ctrl+Alt+S repeat=false { spawn-sh "waysnap output -e"; }

                        XF86AudioMute repeat=false allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
                        XF86AudioMicMute repeat=false allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
                        XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"; }
                        XF86AudioLowerVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"; }

                        XF86MonBrightnessUp allow-when-locked=true { spawn-sh "brightnessctl s 5%+"; }
                        XF86MonBrightnessDown allow-when-locked=true { spawn-sh "brightnessctl s 5%-"; }
                    }
                '';
            };
            noctalia.enable = true;
        };
    };


    #--- Options --------------------------------
    programs.git = {
        enable = true;
        settings.user.name = "jaimarl";
        settings.user.email = "jaimarl.me@gmail.com";
    };

    
    xdg.configFile."noctalia/lockscreen-widgets.toml".source = ./noctalia-widgets.toml;
    programs.noctalia.settings = {
        wallpaper.transition_on_startup = true;
        battery.warning_threshold = 10;
        audio.enable_overdrive = true;
        location.address = "Volgodonsk, Russia";

        shell = {
            middle_click_opens_widget_settings = false;
            polkit_agent = true;
            password_style = "random";
            screen_time_enabled = true;

            panel = {
                open_near_click_control_center = true;
                open_near_click_session = true;
                open_near_click_wallpaper = true;
                shadow = false;
            };

            session.actions = [
                {
                    action = "lock";
                    enabled = true;
                    shortcut = "1";
                    variant = "default";
                }
                {
                    action = "logout";
                    enabled = true;
                    shortcut = "2";
                    variant = "default";
                }
                {
                    action = "lock_and_suspend";
                    enabled = true;
                    glyph = "zzz";
                    label = "Сон";
                    shortcut = "3";
                    variant = "default";
                }
                {
                    action = "reboot";
                    enabled = true;
                    shortcut = "4";
                    variant = "default";
                }
                {
                    action = "shutdown";
                    enabled = true;
                    shortcut = "5";
                    variant = "default";
                }
            ];
        };

        control_center = {
            shortcuts = [
                { type = "wifi"; }
                { type = "bluetooth"; }
                { type = "caffeine"; }
                { type = "notification"; }
            ];
        };

        notification = {
            offset_x = 8;
            offset_y = 8;
        };

        osd = {
            offset_y = 8;
            kinds.keyboard_layout = false;
        };

        idle = {
            behavior_order = [ "lock" "screen-off" "lock-and-suspend" ];
            behavior.lock = {
                action = "lock";
                enabled = true;
                timeout = 600;
            };
            behavior.screen-off = {
                action = "screen_off";
                enabled = true;
                timeout = 660;
            };
            behavior.lock-and-suspend = {
                action = "lock_and_suspend";
                enabled = true;
                timeout = 900;
            };
        };

        bar.default = {
            capsule = true;
            margin_edge = 6;
            radius = 10;
            shadow = false;
            center = [ "date" ];
            end = [ "tray" "keyboard_layout" "brightness" "input_volume" "output_volume" "battery" "session" ];
            start = [ "control-center" "workspaces" "media" ];
        };
        
        widget = {
            control-center.glyph = "snowflake";
            media = {
                max_length = 180;
                title_scroll = "always";
            };
            date.format = " {:%A, %e %B  •  %H:%M} ";
            tray.drawer = true;
            input_volume = {
                scroll_step = 2;
                show_label = false;
            };
            output_volume.scroll_step = 2;
            battery.display_mode = "graphic";
        };
    };

}
