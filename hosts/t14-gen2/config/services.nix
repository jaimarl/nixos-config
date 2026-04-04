{ pkgs, ... }: {

    services.v2raya = {
        enable = true;
        cliPackage = pkgs.xray;
    };

    services.logind.settings.Login = {
        HandlePowerKey = "ignore";
    };

    services.keyd = {
        enable = true;
        keyboards = {
            default = {
                settings = {
                    main = {
                        sysrq = "layer(meta)";
                    };
                };
            };
        };
    };

}
