{ config, lib, pkgs, ... }: {
options.modules.system.hardware.audio.enable = lib.mkEnableOption "Pipewire";

config = lib.mkIf config.modules.system.hardware.audio.enable {

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

};}
