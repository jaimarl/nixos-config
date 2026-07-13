{ inputs, config, lib, ... }: let
    option = config.modules.system.zapret;
in {

    imports = [ inputs.zapret-discord-youtube.nixosModules.default ];

#--- [ Options ] ----------------------------------------------------
options.modules.system.zapret = {
    enable = lib.mkOption { type = lib.types.bool; default = false; };

    strategy = lib.mkOption { type = lib.types.str; default = "general"; };
    listGeneral = lib.mkOption { type = lib.types.listOf lib.types.str; default = []; };
    listExclude = lib.mkOption { type = lib.types.listOf lib.types.str; default = []; };
    ipsetAll = lib.mkOption { type = lib.types.listOf lib.types.str; default = []; };
    ipsetExclude = lib.mkOption { type = lib.types.listOf lib.types.str; default = []; };
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    services.zapret-discord-youtube = {
        enable = true;
        configName = option.strategy;

        listGeneral = [] ++ option.listGeneral;

        listExclude = [] ++ option.listExclude;

        ipsetAll = [] ++ option.ipsetAll;

        ipsetExclude = [] ++ option.ipsetExclude;
    };

};}
