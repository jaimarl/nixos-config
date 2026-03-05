{ config, lib, pkgs, ... }: let
    option = config.modules.system.hardware.audio;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.system.hardware.audio = {
    enable = lib.mkEnableOption "Pipewire";

    monoPlayback = lib.mkEnableOption "Audio Mono Playback";
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    environment.systemPackages = with pkgs; [
        pulsemixer
    ];

    services.pipewire = {
        enable = true;

        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };

    services.pipewire.extraConfig.pipewire."99-mono-output" = lib.mkIf option.monoPlayback {
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
