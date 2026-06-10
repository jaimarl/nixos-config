{ config, lib, pkgs, ... }: let
    option = config.core.audio;
in {

#--- [ Options ] ----------------------------------------------------
options.core.audio = {
    monoPlayback.enable = lib.mkOption { type = lib.types.bool; default = false; };
};


#--- [ Config ] -----------------------------------------------------
config = {

    environment.systemPackages = with pkgs; [
        pulsemixer
    ];

    services.pipewire = {
        enable = true;

        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
        wireplumber.enable = true;
    };

    services.pipewire.extraConfig.pipewire."99-mono-output" = lib.mkIf option.monoPlayback.enable {
        "context.modules" = [{
            name = "libpipewire-module-loopback";
            args = {
                "node.description" = "Mono Playback Device";
                "capture.props" = {
                    "node.name" = "mono_output";
                    "media.class" = "Audio/Sink";
                    "audio.position" = [ "MONO" ];
                };
                "playback.props" = {
                    "node.name" = "playback.mono_output";
                    "audio.position" = ["MONO"];
                    "node.passive" = true;
                };
            };
        }];
    };

};}
