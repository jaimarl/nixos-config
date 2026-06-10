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

    programs.noctalia-shell.settings = lib.mkForce ./noctalia-config.json;

}
