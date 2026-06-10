{ pkgs, ... }: {

    services = {
        v2raya = {
            enable = true;
            cliPackage = pkgs.xray;
        };

        upower.enable = true;

        logind.settings.Login = {
            HandlePowerKey = "ignore";
        };

        keyd = {
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
    };

}
