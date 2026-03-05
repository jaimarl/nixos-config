{ pkgs, ... }: {

    services.envfs.enable = true;

    services.v2raya = {
        enable = true;
        cliPackage = pkgs.xray;
    };

}
