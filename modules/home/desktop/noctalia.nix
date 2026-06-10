{ inputs, config, lib, ... }: let
    option = config.modules.home.desktop.noctalia;
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
    
    programs.noctalia-shell.enable = true;

    xdg.configFile."niri/noctalia.kdl".text = lib.mkIf niri.enable ''
        spawn-at-startup "noctalia-shell"

        binds {
            Mod+Space { spawn-sh "noctalia-shell ipc call launcher toggle"; }
            Mod+C { spawn-sh "noctalia-shell ipc call launcher clipboard"; }
            Mod+L { spawn-sh "noctalia-shell ipc call lockScreen lock"; }
            Ctrl+Alt+Delete { spawn-sh "noctalia-shell ipc call sessionMenu toggle"; }
        }

        layout {
            background-color "transparent"
        }

        layer-rule {
            match namespace="^noctalia-wallpaper*"
            place-within-backdrop true
        }

        layer-rule {
            match namespace="^noctalia-(background|launcher-overlay|dock)-.*$"
            opacity ${toString niri.opacity}
            background-effect {
                blur true
                xray false
            }
        }
    '';

};}
