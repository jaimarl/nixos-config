{ pkgs, ... }: {

    services.v2raya = {
        enable = true;
        cliPackage = pkgs.xray;
    };

    services.logind.settings.Login = {
        HandlePowerKey = "ignore";
    };

}
