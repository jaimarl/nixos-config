{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        greetd
        tuigreet
    ];

    services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.tuigreet}/bin/tuigreet -r --time --time-format '%A, %d %B - %H:%M' --window-padding 1 --cmd Hyprland";
            user = "greeter";
          };
        };
    };

    systemd.services.greetd.serviceConfig = {
        Type = "idle";
        StandartInput = "tty";
        StandartOutput = "tty";
        StandartError = "journal";
        TTYReset = true;
        TTYVHangup = true;
        TTYVTDisallocate = true;
    };
}
