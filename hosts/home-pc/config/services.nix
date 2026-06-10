{ pkgs, ... }: {

    services = {
        v2raya = {
            enable = true;
            cliPackage = pkgs.xray;
        };

        logind.settings.Login = {
            HandlePowerKey = "ignore";
        };
    };

}
