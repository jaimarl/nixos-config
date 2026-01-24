{
    services.v2raya.enable = true;

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
