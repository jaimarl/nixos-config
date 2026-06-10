{ inputs, config, lib, ... }: let
    option = config.modules.home.desktop.noctalia;
    colors = config.lib.stylix.colors.withHashtag;
    niri = config.modules.home.desktop.niri;
in {

    imports = [
        inputs.noctalia.homeModules.default
    ];

#--- [ Options ] ----------------------------------------------------
options.modules.home.desktop.noctalia = {
    enable = lib.mkOption { type = lib.types.bool; default = false; };
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable { 
    
    programs.noctalia = {
        enable = true;
        settings = {
            theme = {
                source = "custom";
                custom_palette = "stylix";
            };
            wallpaper = {
                directory = builtins.replaceStrings [ "$HOME" ] [ config.home.homeDirectory ] config.host.home.paths.wallpapers;
            };
            shell.niri_overview_type_to_launch_enabled = lib.mkIf niri.enable true;

            # Niri Opacity
            dock.background_opacity = lib.mkIf niri.enable niri.opacity;
            notification.background_opacity = lib.mkIf niri.enable niri.opacity;
            osd.background_opacity = lib.mkIf niri.enable niri.opacity;
            bar.default.background_opacity = lib.mkIf niri.enable niri.opacity;
        };
    };

    xdg.configFile."niri/noctalia.kdl".text = lib.mkIf niri.enable ''
        spawn-at-startup "noctalia"

        binds {
            Mod+Space { spawn-sh "noctalia msg panel-toggle launcher"; }
            Mod+C { spawn-sh "noctalia msg panel-toggle clipboard"; }
            Mod+L { spawn-sh "noctalia msg session lock"; }
            Ctrl+Alt+Delete { spawn-sh "noctalia msg panel-toggle session"; }
        }

        layout {
            background-color "transparent"
        }

        layer-rule {
            match namespace="^noctalia-wallpaper"
            place-within-backdrop true
        }

        layer-rule {
            match namespace="^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$"
            background-effect {
                xray false
            }
        }
        layer-rule {
            match namespace="^noctalia-panel$"
            opacity ${toString niri.opacity}
        }
    '';

    xdg.configFile."noctalia/palettes/stylix.json".text = builtins.toJSON {
        dark = {
            mPrimary = colors.base0D;
            mOnPrimary = colors.base00;
            mSecondary = colors.base0E;
            mOnSecondary = colors.base00;
            mTertiary = colors.base0C;
            mOnTertiary = colors.base00;
            mError = colors.base08;
            mOnError = colors.base00;
            mSurface = colors.base00;
            mOnSurface = colors.base05;
            mHover = colors.base0C;
            mOnHover = colors.base00;
            mSurfaceVariant = colors.base01;
            mOnSurfaceVariant = colors.base04;
            mOutline = colors.base03;
            mShadow = colors.base00;
            terminal = {};
        };
    };

};}
