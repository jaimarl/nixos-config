{ config, lib, pkgs, ... }: let
    option = config.modules.system.boot.tuigreet;
in {

#--- [ Options ] ---------------------------------------------------- 
options.modules.system.boot.tuigreet = {
    enable = lib.mkOption { type = lib.types.bool; default = false; };
};


#--- [ Config ] -----------------------------------------------------
options.modules.system.boot.tuigreet = {
};

config = lib.mkIf option.enable {

    environment.systemPackages = with pkgs; [
        greetd
        tuigreet
    ];

    services.greetd = {
        enable = true;
        settings = {
            default_session = {
                command = "${pkgs.tuigreet}/bin/tuigreet -r --remember-user-session --time --time-format '%A, %d %B - %H:%M' --window-padding 1";
                user = "greeter";
            };
        };
    };

    systemd.services.greetd.serviceConfig = {
        Type = "idle";
        StandardInput = "tty";
        StandardOutput = "tty";
        StandardError = "journal";
        TTYReset = true;
        TTYVHangup = true;
        TTYVTDisallocate = true;
    };

};}
