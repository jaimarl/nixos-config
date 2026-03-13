{ config, hmConfig, lib, pkgs, ... }: let
    option = config.modules.system.boot.tuigreet;
in {

#--- [ Options ] ---------------------------------------------------- 
options.modules.system.boot.tuigreet = {
    enable = lib.mkOption { type = lib.types.bool; default = false; };

    cmd = lib.mkOption { type = lib.types.str; default = "zsh"; };
};


#--- [ Config ] -----------------------------------------------------
options.modules.system.boot.tuigreet = {
};

config = lib.mkIf option.enable {

    environment.systemPackages = with pkgs; [
        greetd
        tuigreet
    ];

    services.greetd = let
        cmd = config.modules.system.boot.tuigreet.cmd;
    in {
        enable = true;
        settings = {
            default_session = {
                command = "${pkgs.tuigreet}/bin/tuigreet -r --time --time-format '%A, %d %B - %H:%M' --window-padding 1 --cmd ${cmd}";
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
