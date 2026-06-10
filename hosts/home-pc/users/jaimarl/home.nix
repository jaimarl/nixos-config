{ pkgs, ... }: {

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
        discord.enable = true;
        desktop = {
            niri = {
                enable = true;
                lockscreen.output = "eDP-1";
                userConfig = ''
                    output "DP-3" {
                        mode "1920x1080@144"
                        position x=0 y=0
                        scale 1
                        hot-corners {
                            off
                        }
                    }
                    output "HDMI-A-1" {
                        mode "1920x1080@60"
                        position x=1920 y=0
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

                        XF86AudioMute repeat=false allow-when-locked=true { spawn-sh "${pkgs.playerctl}/bin/playerctl -p spotify play-pause"; }
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

    programs.noctalia.settings = {
        wallpaper.transition_on_startup = true;
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
            behavior_order = [ "lock" ];
            pre_action_fade_seconds = 0;
            behavior.lock = {
                action = "lock";
                enabled = true;
                timeout = 600;
            };
        };

        bar.default = {
            capsule = true;
            margin_edge = 6;
            radius = 10;
            shadow = false;
            center = [ "date" ];
            end = [ "tray" "keyboard_layout" "input_volume" "output_volume" "session" ];
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
        };
    };

}
