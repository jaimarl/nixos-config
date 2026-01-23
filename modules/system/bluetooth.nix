{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        bluetui
    ];

    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
            General = {
                Enable = "Source,Sink,Media,Socket";
                Experimental = true;
            };
        };
    };
}
